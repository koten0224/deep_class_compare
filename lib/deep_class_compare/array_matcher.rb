require "deep_class_compare/matcher.rb"
require "deep_class_compare/container_comparable.rb"
module DeepClassCompare
  class ArrayMatcher < Matcher
    include ContainerComparable
    def initialize
      super(Array)
    end

    def match?(array)
      # p @chain
      super && compare_array_with_chain(array)
    end

    def of(*comparable)
      dup.tap do |matcher|
        matcher.instance_eval do
          @chain = if @chain.nil?
            parse_comparable_to_chain(comparable.first)
          elsif @chain.is_a?(Matcher)
            @chain.of(*comparable)
          end
          raise_pattern_error! if @chain.nil?
        end
      end
    end

    private
    def compare_array_with_chain(array)
      array.all? do |value|
        compare_chain(value, @chain)
      end
    end
  end
end