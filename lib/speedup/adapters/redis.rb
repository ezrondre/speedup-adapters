require 'speedup/adapters/base'
require 'redis'

module Speedup
  module Adapters
    class Redis < Base
      def initialize(options = {})
        @expires_in = Integer(options.delete(:expires_in) || 60 * 30)
        @client = options.fetch(:client, ::Redis.new(options))
      end

      def get(request_id)
        @client.get("speedup:requests:#{request_id}")
      end

      def write(request_id, data)
        @client.setex("speedup:requests:#{request_id}", @expires_in, data.to_json)
      end
    end
  end
end
