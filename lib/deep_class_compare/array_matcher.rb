module DeepClassCompare
  class ArrayMatcher < Matcher
    include ContainerComparable
    def initialize
      super(Array)
    end

    def match?(array)
      super && compare_array_with_chain(array)
    end

    def of(*comparable)
      dup.tap do |matcher|
        matcher.build_chain(*comparable)
      end
    end

    def build_chain(*comparable)
      @chain = if @chain.nil?
        parse_comparable_to_chain(comparable.first)
      elsif @chain.is_a?(Matcher)
        @chain.of(*comparable)
      end
      raise_pattern_error! if @chain.nil?
    end

    private
    def compare_array_with_chain(array)
      array.all? do |value|
        compare_chain(value, @chain)
      end
    end
  end
end