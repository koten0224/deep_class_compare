# frozen_string_literal: true

require_relative "deep_class_compare/version"
require_relative "deep_class_compare/matcher"
require_relative "deep_class_compare/array_matcher"
module DeepClassCompare
  class Error < StandardError; end
  class TypeError < Error; end
  # Your code goes here...
end

class Array
  def self.of(value_comparable)
    DeepClassCompare::ArrayMatcher.new.of(value_comparable)
  end
end

class Object
  def like_a?(class_or_matcher)
    if class_or_matcher.is_a? DeepClassCompare::Matcher
      class_or_matcher.match?(self)
    else
      is_a?(class_or_matcher)
    end
  end
end