require "./lib/deep_class_compare/matcher.rb"
module DeepClassCompare
  class ArrayMatcher < Matcher
    def of(comparable)
      dup.tap do |matcher|
        matcher.instance_eval do
          @chain = if @chain.nil?
            parse_comparable_to_chain(comparable)
          elsif @chain.is_a?(Matcher)
            @chain.of(comparable)
          end
          raise_pattern_error! if @chain.nil?
        end
      end
    end

    private
    def parse_comparable_to_chain(comparable)
      case comparable
      when Matcher
        comparable
      when Array
        parse_array_to_chain(comparable)
      when Class
        parse_class_to_matcher(comparable)
      end        
    end

    def parse_array_to_chain(array)
      case array.count
      when 0 then raise_pattern_error!
      when 1 then parse_comparable_to_chain(array.first)
      else
        array.map do |sub_comparable|
          parse_comparable_to_chain(sub_comparable)
        end
      end
    end

    def parse_class_to_matcher(klass)
      if klass == Array
        ArrayMatcher.new(klass)
      else 
        Matcher.new(klass)
      end
    end
  end
end