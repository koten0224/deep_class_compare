require "./lib/deep_class_compare/matcher.rb"
require "./lib/deep_class_compare/container_comparable.rb"
module DeepClassCompare
  class HashMatcher < Matcher
    include ContainerComparable

    def initialize
      super(Hash)
    end

    def of(key_comparable, value_comparable)
      dup.tap do |matcher|
        matcher.instance_eval do
          raise_pattern_error! unless @key_chain.nil? && @value_chain.nil?
          @key_chain = parse_comparable_to_chain(key_comparable)
          @value_chain = parse_comparable_to_chain(value_comparable)
        end
      end
    end
  end
end