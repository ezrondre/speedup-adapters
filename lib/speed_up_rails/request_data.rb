module SpeedUpRails
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

    def load(contexts, data)
      @contexts = contexts.map(&:to_sym)
      self.merge!(data.symbolize_keys)
    end

  end
end
