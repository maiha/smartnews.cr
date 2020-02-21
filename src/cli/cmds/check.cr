Cmds.command "check" do
  task mem do
    info = Pretty::MemInfo.process
    info.values.each do |key, val|
      puts "#{key}: #{val}"
    end
  end
end
