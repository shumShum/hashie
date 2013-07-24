module HashieUndev

  class Clash < Hash

    attr_accessor :is_where

    def where(*args)
      self[:where] ||= {}
      self[:where].merge! *args
      self
    end

    def order(*args)
      self[:order] = args.size == 1 ? args[0] : args
      self 
    end
    
    def where!
      self[:where] = {}
      self.is_where = true
      self
    end

    def _end!
      self.is_where = false
      self
    end
    
    def method_missing(meth, *args, &block)
      # binding.pry
      define_singleton_method(meth) do |value|
        if self.is_where
          self[:where].merge!({meth => args[0]})
          self
        else
          raise NoMethodError
        end
      end

      send meth, *args
    end

  end
end