module StringRefinements
  refine String do

    def when_matches_with(*value)
      value = [value] if value.is_a?(String)
      @match_values = value
      self
    end

    def but_not(*value)
      value = [value] if value.is_a?(String)
      @excluded_values = value
      self
    end

    def within?(text)
      text.upcase!
      return false if excluded_values.any? { |value| text.include?(value.upcase) }
      return true if match_values.any? { |value| text.include?(value.upcase) }
      text.include?(self.upcase)
    end

    private

    def match_values
      @match_values ||= []
    end

    def excluded_values
      @excluded_values ||= []
    end

  end
end