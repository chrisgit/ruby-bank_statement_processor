module BankStatements

  class HashCategory

    attr_reader :processor
    attr_reader :info

    def initialize(categories = nil)
      @category_hash = categories || HashCategories.default_categories
      @processor = HashCategoryProcessor.new(@category_hash)
      @info = HashCategoryInfo.new(@category_hash)
    end

    def process_category(description)
      @processor.process_category(description)
    end

  end
end
