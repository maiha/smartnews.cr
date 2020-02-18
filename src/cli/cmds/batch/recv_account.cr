class Cmds::BatchCmd
  def recv_account
    hint = "[recv] accounts"

    client = new_client
    url    = "/api/v1.0/accounts"
    house  = house(Smartnews::Proto::Account)
    converter = converter(Array(Smartnews::Converter::Account))

    recv.start
    recv_impl(client, url, house, converter, hint)
    recv.stop

    msg = "%s %s [%s]" % [hint, house.count, recv.last.to_s]
    update_status msg, logger: "INFO", flush: true
  end
end
