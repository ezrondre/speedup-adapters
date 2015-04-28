require 'httparty'
require 'speedup/adapters/memory'

module Speedup
  module Adapters

    class Server
      include HTTParty

      def initialize(options = {})
        @url = options[:url]
        @api_key = options[:api_key]
        @memory = Speedup::Adapters::Memory.new
      end

      def get(request_id)
        @memory.get(request_id)
      end

      def write(request_id, data)
        @memory.write(request_id, data)

        opts = {
          body: {request_id: request_id, contexts: data.contexts, data: data}.to_json,
          headers: {"Content-Type" => "application/json", "X-SUR-API-Key" => @api_key},
        }
        self.class.post(@url + '/requests.json', opts )
      end
    end
  end
end