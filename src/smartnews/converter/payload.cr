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
  
  def to_pb
    data!.to_pb
  end
  
  def to_pbs
    data!.map(&.to_pb)
  end
end
