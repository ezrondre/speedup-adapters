require 'speedup/adapters/base'

module Speedup
  module Adapters
    class Memory < Base
      attr_accessor :requests

      def initialize(options = {})
        super
        @path = Rails.root.join('log', 'speedup')
        unless File.exists?(@path)
          require 'fileutils'
          FileUtils.mkdir_p(@path)
        end
      end

      def get(request_id)
        file = YAML::load_file(@path.join(request_id.to_s+'.yml'))
        Speedup::RequestData.new.load(file[:contexts], file[:data])
      end

      def write(request_id, data)
        File.open(@path.join(request_id.to_s+'.yml'), 'w') {|f| f.write({contexts: data.contexts, data: data}.to_yaml) }
      end

      def reset
        @requests.clear
      end
    end
  end
end
