# It seems that Crystal will take a long time to compile with many macros and generics.
# So, pb now can be opt-out by compilation flag.
#
# [00:00:06] crystal
# [00:00:34] crystal --release
# [00:00:32] crystal -D with_pb
# [00:35:15] crystal -D with_pb --release

Cmds.command "pb" do
  include Enumerable(Protobuf::Message)

  usage "count HttpCall.pb               # show the count"
  usage "list  HttpCall.pb -v -l 1       # show first entry"
  usage "list  HttpCall.pb               # show all entries"
  usage "list  HttpCall.pb -f url,status"
  usage "grep 'status!=200' HttpCall.pb"
  
  var files  : Array(String)
  var fields : Array(String)
  var filter : Filter
  var limit  : Int32
  
  def before
    self.fields = config.fields?.try(&.split(",")) || Array(String).new
    self.limit  = config.limit? || 100_000_000
    self.logger = Logger.new(nil)
  end

  task "count" do
    puts size
  end
  
  task "grep" do
    # list already has grep features
    invoke_task("list")
  end
  
  task "list" do
    each_with_index do |pb, i|
      show(pb, i)
    end
  end

  task "show" do
    each do |pb|
      p pb
    end
  end

  task "head" do
    each_with_index do |pb, i|
      show(pb, i)
      break
    end
  end

  task "tail" do
    pb = nil
    i = -1
    each do |x|
      i += 1
      pb = x
    end
    if pb
      show(pb, i)
    end
  end

  usage "json2schema response.json Campaign  # convert to protobuf schema"
  task "json2schema" do
    path  = arg1? || raise Cmds::ArgumentError.new("need json file")
    klass = arg2? || File.basename(path, ".json").capitalize
    hash  = JSON.parse(File.read(path)).as_h? || raise Cmds::ArgumentError.new("json file should be Hash")
    json2schema(hash, klass)
  end

  usage "schema2renum campaign.proto # renumber schema"
  task "schema2renum" do
    path  = arg1? || raise Cmds::ArgumentError.new("need proto schema")
    lines = File.read(path).split(/\n/)
    schema2renum(lines)
  end

  usage "schema2converter campaign.proto Smartnews::"
  task "schema2converter" do
    path   = arg1? || raise Cmds::ArgumentError.new("need proto schema")
    prefix = arg2?
    proto  = File.read(path)
    schema2converter(proto, prefix)
  end
  
  usage "schema2clickhouse campaign.proto # convert to ClickHouse table"
  task "schema2clickhouse" do
    path = arg1? || raise Cmds::ArgumentError.new("need proto schema")
    puts schema2clickhouse(File.read(path)).to_sql
  end
  
  abstract class Cond
    def initialize(@key : String, @val : String)
    end

    abstract def =~(pb : Protobuf::Message) : Bool

    def !~(pb : Protobuf::Message) : Bool
      ! self.=~(pb)
    end
  end

  class Cond::Eq < Cond
    def =~(pb : Protobuf::Message)
      pb[@key].to_s == @val.to_s
    end
  end
  
  class Cond::Not < Cond
    def =~(pb : Protobuf::Message)
      pb[@key].to_s != @val.to_s
    end
  end
  
  private record Filter, conds : Array(Cond) = Array(Cond).new do
    def =~ (pb)
      ! (self !~ pb)
    end

    def !~ (pb)
      conds.any?(&.!~(pb))
    end
  end
  
  private def each : Nil
    if ! files?
      logger.debug "parse args for each: %s" % args.inspect
      self.filter = build_filter!(args)
      args.any? || raise Cmds::ArgumentError.new("need pb file")
      self.files = expand_files(args)
    end

    i = 0
    files.each do |file|
      load_pbs(file).each do |pb|
        next if filter !~ pb
        i += 1
        yield pb
        raise Finished.new if i == limit
      end
    end
  rescue err : Protobuf::Error
    if err.to_s =~ /Field not found/
      raise Cmds::ArgumentError.new err.to_s
    else
      raise err
    end
  rescue Finished
  end

  private def build_filter!(args)
    filter = Filter.new
    args.dup.each do |arg|
      case arg
      when /^(.*?)!=(.*)$/
        filter.conds << Cond::Not.new($1, $2)
      when /^(.*?)=(.*)$/
        filter.conds << Cond::Eq.new($1, $2)
      else
        break
      end
      args.shift
    end
    return filter
  end

  # Returns the pb file names under the args directory
  private def expand_files(args : Array(String)) : Array(String)
    logger.debug "expand_files: << %s" % args.inspect
    files = Array(String).new
    args.each do |file|
      if Dir.exists?(file)
        Dir["#{file}/**/*"].each do |f|
          if f =~ /\.pb\.gz$/
            files << f
          end
        end
      else
        files << file
      end
    end

    files = files.map{|file|
      begin
        File.real_path(file)
      rescue Errno
        raise Cmds::ArgumentError.new("No such file or directory '%s'" % file)
      end
    }.uniq.sort

    logger.debug "expand_files: >> %s" % files.inspect
    return files
  end

  {% begin %}
  private def load_pbs(file)
    # file = "tmp/HttpCall/foo.pb"
    type_candidates = Array(String).new

    # first, guess by file name
    type_candidates << File.basename(file).split(".").first
    # => ["foo"]

    # second, guess by directory name
    type_candidates.concat File.dirname(file).split("/")
    # => ["foo", "tmp", "HttpCall", "foo"]
    
    type_candidates.each do |type_name|
      {% for klass_name in Protobuf::Message::IncludedNames.reject{|i| i =~ /Array$/} %}
        if {{klass_name}} == type_name
          logger.debug "load '%s' using '%s' schema" % [file, {{klass_name}}]
          return Protobuf::Storage({{klass_name.id}}).load(file)
        end
      {% end %}
    end

    # can't guess the type of Protobuf::Message
    raise Cmds::ArgumentError.new "cannot guess pb class for '#{file}'"
  end
  {% end %}

  private def show(pbs : Array(Protobuf::Message))
    pbs.each_with_index do |pb, i|
      show(pb, i)
    end
  end

  private def show(pb : Protobuf::Message, i : Int32)
    if config.format? == "pb"
      print pb.to_protobuf
      return
    end

    if config.verbose?
      show_item_delimiter(i)
      lines = Array(Array(String)).new
      pb.to_hash.each do |k, v|
        lines << [k.to_s, v.inspect]
      end
      puts Pretty.lines(lines, indent: "  ", delimiter: " : ").split(/\n/).map(&.sub(/\s+$/,"")).join("\n")
      puts
    else
      case fields.size
      when 0
        puts pb.to_s
      when 1
        puts pb[fields.first]
      else
        puts fields.map{|f| hpath(pb, f.split(".")).to_s.gsub(/\s+/," ")}.join(",")
      end
    end
  end

  private def show_item_delimiter(index : Int32)
    puts <<-EOF
      Row #{index+1}:
      ──────
      EOF
  end

  private def hpath(pb : Protobuf::Message, paths : Array(String))
    obj = pb
    paths.each do |key|
      case obj
      when Nil
        break
      when Protobuf::Message
        obj = obj[key]
      else
        raise Cmds::ArgumentError.new("'%s' expects pb, but got '%s'" % [paths.join("."), obj.class.to_s])
      end
    end
    return obj
  end

  protected def json2schema(hash, klass)
    outputs = Array(Array(String)).new
    hash.each do |name, sample|
      seq = outputs.size + 1
      outputs << [pb_rule(sample), pb_type(sample), name, "=", seq.to_s, "; //", sample.inspect]
    end

    body = Pretty.lines(outputs, delimiter: " ", indent: "  ").split(/\n/).map(&.sub(/\s+$/,"")).join("\n")
    
    puts <<-EOF
      syntax = "proto2";

      message #{klass} {
      #{body}
      }

      message #{klass}Array {
        repeated #{klass} array = 1;
      }
      EOF
  end

  protected def schema2renum(lines : Array(String))
    seq = 0
    # message Report {
    #   optional string   date                    = 1;
    lines.each do |line|
      case line
      when /^(\s*(optional|repeated|required)\s+.*?)=\s*(\d+)\s*;(.*?)$/
        key,_d,num,rest = $1,$2,$3,$4
        seq += 1
        puts "%s=%3d; %s" % [key, seq, rest.strip]
      when /^\s*message\b/
        seq = 0
        puts line
      else
        puts line
      end
    end
  end

  record Schema, name : String, type : String, underscore : String, sample : String
  
  protected def schema2converter(protobuf_schema : String, prefix = nil)
    lines   = protobuf_schema.split(/\n/)
    klass   = "XXX"
    schemas = Array(Schema).new

    clickhouse = schema2clickhouse(protobuf_schema)
    
    group_seq = 0

    lines.each do |line|
      case line
      when /^\s*(optional|repeated|required)\s+(.*?)\s+(.*?)\s*=\s*(\d+)\s*;(.*?)$/
        rule,type,name,num,rest = $1,$2,$3,$4,$5
        # id:  String,  # "8wku2"
        sample = rest.sub(%r{\A\s*//}, "").strip
        schemas << Schema.new(name: name, type: cr_type(rule, type, name), underscore: name.underscore, sample: sample)
      when /^\s*message\s+([^\s]+)/
        group_seq += 1
        break if group_seq > 1
        klass = $1
      end
    end

    lines = schemas.map{|s| ["#{s.name}:", s.type, ", # #{s.sample}"]}
    pretty_from_json = Pretty.lines(lines, delimiter: " ", indent: "    ").split(/\n/).map(&.sub(/\s+$/,"")).join("\n")
    pretty_to_pb = schemas.map{|s| "      #{s.underscore}: #{s.name},"}.join("\n")

    puts <<-END_OF_CLASS
      class #{prefix}Converter::#{klass}
        ######################################################################
        ### JSON

        JSON.mapping({
      #{pretty_from_json}
        })

        ######################################################################
        ### Protobuf

        def to_pb
          #{prefix}Proto::#{klass}.new(
      #{pretty_to_pb}
          )
        end

        def self.protobuf_schema : ProtobufSchema::Schema
          ProtobufSchema.parse(protobuf_schema_string)
        end

        def self.protobuf_schema_string : String
          <<-EOF
            #{protobuf_schema.gsub(/^/m, "      ").strip}
            EOF
        end

        ######################################################################
        ### ClickHouse

        def self.clickhouse_create : Clickhouse::Schema::Create
          Clickhouse::Schema::Create.parse(clickhouse_schema_sql)
        end

        def self.clickhouse_schema_sql
          <<-EOF
            #{clickhouse.to_sql.gsub(/^/m, "      ").strip}
            EOF
        end
      end
      END_OF_CLASS
  end

  protected def schema2clickhouse(buf : String)
    klass   = "XXX"
    outputs = Array(Array(String)).new

    schema = ProtobufSchema.parse(buf)
    create = Clickhouse::Schema::Create.new
    create.table = Pretty.underscore(schema.klass)
    schema.fields.each do |f|
      name = Pretty.underscore(f.name)
      type = f.clickhouse_type
      create.columns << Clickhouse::Column.new(name, type)
    end
    create.engine = "Log"
    return create
  end

  private def pb_rule(value : JSON::Any) : String
    value.as_a? ? "repeated" : "optional"
  end

  private def cr_type(rule, type, name): String
    klass = {
      "int64"  => "Int64",
      "bool"   => "Bool",
      "double" => "Float64",
    }[type]? || "String"

    return klass if name == "id"
    
    case rule
    when "optional"; "#{klass}?"
    when "repeated"; "Array(#{klass})"
    else           ; klass
    end
  end

  private def pb_type(value : JSON::Any) : String
    case value.raw
    when Bool             ; "bool"
    when Int32, Int64     ; "int64"
    when Float32, Float64 ; "double"
    else                  ; "string"
    end
  end
end
