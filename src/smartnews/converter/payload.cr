class Smartnews::Converter::Payload(T)
  JSON.mapping({
    data: T?,
    error: ErrorResponse?,
  })

  def error? : ErrorResponse?
    error
  end

  def data! : T
    if data
      return data.not_nil!
    elsif err = error?
      raise err
    else
      raise Smartnews::Error.new("response doesn't contain data nor error")
    end
  end

  def to_pbs
    {% if @type.type_vars.first.name.stringify =~ /^Array\(/ %}
      data!.map(&.to_pb)
    {% else %}
      [data!.to_pb]
    {% end %}
  end
end
