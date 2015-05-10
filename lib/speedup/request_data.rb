module Speedup
  class RequestData < Hash

    def contexts
      @contexts ||= []
    end

    def storage_for(context)
      @contexts ||= []
      @contexts |= [context]
      self[context] ||= {} if context == :request
      self[context] ||= []
    end

    def load(contexts, data=nil)
      unless data
        raise 'load with one parametr expect a Hash to be a provided as a parametr' unless contexts.is_a?(Hash)
        data = contexts
        contexts = data.keys
      end
      @contexts = contexts.map(&:to_sym)
      self.merge!(data.symbolize_keys)
    end

  end
end
