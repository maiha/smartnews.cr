require "../dryrun"

module Smartnews::Strategy
  class Dryrun < Base
    def execute(req : Request) : Response
      raise Smartnews::Dryrun.new(req)
    end
  end
end
