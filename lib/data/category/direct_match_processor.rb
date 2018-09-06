module BankStatements

  class DirectMatchProcessor

    def initialize(category_match)
      @category_match = category_match
    end

    def match(description)
      @category_match
    end

    def keys
      @category_match
    end
  end
end
