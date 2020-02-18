require "./account.pb"

struct Smartnews::Proto::Account
  def account_id! : String
    account_id || raise ArgumentError.new("account_id is nil")
  end

  def to_s(io : IO)
    io << "Account(id=#{account_id.inspect}, #{name.inspect})"
  end
end
