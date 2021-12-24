module DeepClassCompare
  module ContainerComparable
    private
    def compare_chain(value, chain)
      case chain
      when Matcher then chain.match?(value)
      when Array then chain.any? { |matcher| matcher.match?(value) }
      else true
      end
    end

    def parse_comparable_to_chain(comparable)
      case comparable
      when Matcher then comparable
      when Array then parse_array_to_chain(comparable)
      when Class then parse_class_to_matcher(comparable)
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
      if klass == Array then ArrayMatcher.new
      elsif klass == Hash then HashMatcher.new
      else Matcher.new(klass)
      end
    end
  end
end