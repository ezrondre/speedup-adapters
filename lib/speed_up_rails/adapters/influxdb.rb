require 'speed_up_rails/adapters/memory'

module SpeedUpRails
  module Adapters
    class Influxdb < Base
      attr_accessor :requests

      def initialize(options = {})
        @memory = SpeedUpRails::Adapters::Memory.new
        @client = InfluxDB::Client.new(options.delete(:database), options)
      end

      def get(request_id)
        @memory.get(request_id)
      end

      def write(request_id, data)
        return unless data.any?
        data.contexts.each do |context|
          [data[context]].flatten.each do |context_data|
            context_data[:request_id] = request_id
            context_data[:time] = context_data[:time].to_f if context_data.has_key?(:time)
            @client.write_point(context.to_s, context_data)
          end
        end
        @memory.write(request_id, data)
      end

      def reset
        @memory.reset
      end
    end
  end
end
