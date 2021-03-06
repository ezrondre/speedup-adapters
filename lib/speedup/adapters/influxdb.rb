require 'speedup/adapters/memory'

module Speedup
  module Adapters
    class Influxdb < Base
      attr_accessor :requests

      def initialize(options = {})
        @memory = Speedup::Adapters::Memory.new
        @client = ::InfluxDB::Client.new(options.delete(:database), options)
      end

      def get(request_id)
        @memory.get(request_id)
      end

      def write(request_id, data)
        return unless data.any?
        data.contexts.each do |context|
          data_points = ( data[context].is_a?(Array) ? data[context] : [data[context]] )
          data_points.each do |context_data|
            context_data[:request_id] = request_id
            context_data[:time] = context_data[:time].to_f if context_data.has_key?(:time)
          end
          @client.write_point(context.to_s, data_points)
        end
        @memory.write(request_id, data)
      end

      def reset
        @memory.reset
      end
    end
  end
end
