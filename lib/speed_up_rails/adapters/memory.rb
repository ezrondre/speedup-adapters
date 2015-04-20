require 'speed_up_rails/adapters/base'

module SpeedUpRails
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
        ap request_id
        ap data.contexts
        ap data
        @requests[request_id] = data
      end

      def reset
        @requests.clear
      end
    end
  end
end
