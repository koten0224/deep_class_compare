# frozen_string_literal: true

require "./lib/deep_class_compare/version"
require "./lib/deep_class_compare/matcher"
require "./lib/deep_class_compare/array_matcher"
require "./lib/deep_class_compare/hash_matcher"
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

class Hash
  def self.of(key_comparable, value_comparable = nil)
    key_comparable, value_comparable = Object, key_comparable if value_comparable.nil?
    DeepClassCompare::HashMatcher.new.of(key_comparable, value_comparable)
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