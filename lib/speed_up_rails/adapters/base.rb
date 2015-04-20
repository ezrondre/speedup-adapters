module SpeedUpRails
  module Adapters
    class Base
      def initialize(options = {})

      end

      def get(request_id)
        raise "#{self.class}#get(request_id) is not yet implemented"
      end

      def write(request_id, data)
        raise "#{self.class}#write(request_id, data) is not yet implemented"
      end
    end
  end
end
