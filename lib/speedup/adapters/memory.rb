require 'speed_up_rails/adapters/base'

module Speedup
  module Adapters
    class Memory < Base
      attr_accessor :requests

      def initialize(options = {})
        @requests = {}
      end

      def get(request_id)
        @requests[request_id]
      end

      def write(request_id, data)
        @requests[request_id] = data
      end

      def reset
        @requests.clear
      end
    end
  end
end
