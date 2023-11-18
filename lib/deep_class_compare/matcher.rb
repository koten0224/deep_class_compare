module DeepClassCompare
  class Matcher
    def self.build(klass)
      if klass.ancestors.include?(Array) then ArrayMatcher.new(klass)
      elsif klass.ancestors.include?(Hash) then HashMatcher.new(klass)
      else new(klass)
      end
    end

    def initialize(base)
      @base = base
      raise_class_required_error! unless @base.is_a?(Module)
    end

    def match?(value)
      value.is_a?(@base)
    end

    private
    def raise_class_required_error!
      raise TypeError.new("class or module required")
    end

    def raise_pattern_error!
      raise TypeError.new("invalid pattern of compare chain")
    end
  end
end
