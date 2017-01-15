module BankStatements

  class HashCategoryProcessor

    def initialize(category_hash = nil)
      @category_hash = category_hash || CATEGORIES
    end

    def process_category(description)
      categories = process_category_item(@category_hash, description)
      categories = categories.flatten.uniq
      return ['Misc'] if categories.empty?
      categories
    end

    private

    def process_category_item(object, description)
      return process_hash(object, description) if (object.is_a?(Hash) && !(object.empty?))
      return process_array(object, description) if object.is_a?(Array)
      return process_string(object, description) if object.is_a?(String)
      []
    end

    def process_hash(object, description)
      match_items = []
      object.each_pair do |key, value|
        matches = process_category_item(value, description)
        next if matches.empty?
        # Key only or key and matching item tags
        if key.start_with?('*')
          match_items << key[1..-1]
        else
          match_items << key << matches
        end
      end
      match_items
    end

    def process_array(object, description)
      match_items = []
      object.each do |item|
        matches = process_category_item(item, description)
        match_items << matches unless matches.empty?
      end
      match_items
    end

    def process_string(object, description)
      return object if description.upcase.include?(object.upcase)
      ''
    end
  end
end