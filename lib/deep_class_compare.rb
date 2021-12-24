# frozen_string_literal: true

require_relative "deep_class_compare/version"
require_relative "deep_class_compare/matcher"
require_relative "deep_class_compare/array_matcher"
module DeepClassCompare
  class Error < StandardError; end
  # Your code goes here...
end

class Array
  def self.of(value_comparable)
    DeepClassCompare::ArrayMatcher.new(self).of(value_comparable)
  end
end
