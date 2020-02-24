Cmds.command "check" do
  task mem do
    if config.verbose?
      info = Pretty::MemInfo.process(skip_invalid: true)
    else
      info = Pretty::MemInfo.process
    end
    info.values.each do |key, val|
      puts "#{key}: #{val}"
    end
    puts info.max.to_s
  end
end
