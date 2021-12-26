module DeepClassCompare
  class HashMatcher < Matcher
    include ContainerComparable
    def initialize
      super(Hash)
    end

    def match?(hash)
      super && compare_hash_with_chain(hash)
    end

    def of(key_comparable, value_comparable = nil)
      raise_pattern_error! unless @key_chain.nil? && @value_chain.nil?
      dup.tap do |matcher|
        matcher.build_chain(key_comparable, value_comparable)
      end
    end

    def build_chain(key_comparable, value_comparable = nil)
      key_comparable, value_comparable = Object, key_comparable if value_comparable.nil?
      @key_chain = parse_comparable_to_chain(key_comparable)
      @value_chain = parse_comparable_to_chain(value_comparable)
    end

    private
    def compare_hash_with_chain(hash)
      hash.all? do |key, value|
        compare_chain(key, @key_chain) &&
        compare_chain(value, @value_chain)
      end
    end
  end
end