require 'speedup/adapters/base'
require 'dalli'

module Speedup
  module Adapters
    class Memcached < Base
      def initialize(options = {})
        @expires_in = options.delete(:expires_in) || 60 * 30
        @client = options[:client] || ::Dalli::Client.new(options.delete(:host), options)
      end

      def get(request_id)
        @client.get("speedup:requests:#{request_id}")
      rescue ::Dalli::DalliError => e
        Rails.logger.error "#{e.class.name}: #{e.message}"
      end

      def save
        @client.add("speedup:requests:#{request_id}", data.to_json, @expires_in)
      rescue ::Dalli::DalliError => e
        Rails.logger.error "#{e.class.name}: #{e.message}"
      end
    end
  end
end
