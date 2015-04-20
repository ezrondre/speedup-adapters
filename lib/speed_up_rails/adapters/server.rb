require 'httparty'

module SpeedUpRails
  module Adapters

    class Server
      include HTTParty

      def initialize(options = {})
        @url = options[:url]
      end

      def get(request_id)
        raise "#{self.class}#get(request_id) is not yet implemented"
      end

      def write(request_id, data)
        opts = {
          body: {request_id: request_id, contexts: data.contexts, data: data}.to_json,
          headers: {"Content-Type" => "application/json"},
        }
        self.class.post(@url + '/requests.json', opts )
      end
    end
  end
end
