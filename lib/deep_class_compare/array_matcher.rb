require "./lib/deep_class_compare/matcher.rb"
require "./lib/deep_class_compare/container_comparable.rb"
module DeepClassCompare
  class ArrayMatcher < Matcher
  include ContainerComparable
    def initialize
      super(Array)
    end

    def match?(array)
      # p @chain
      super && compare_chain(array)
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
  end
end