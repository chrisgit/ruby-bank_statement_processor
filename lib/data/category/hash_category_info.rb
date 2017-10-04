module BankStatements

  # TODO: merge with the processor above, create methods for working out alias key, i.e. hash key starting with *
  class HashCategoryInfo

    def initialize(category_hash = nil)
      @category_hash = category_hash || CATEGORIES
    end

    def to_a()
      categories = process_category_item(@category_hash)
      categories << 'Misc'
      categories.flatten.uniq
    end

    private

    def process_category_item(object)
      return process_hash(object) if (object.is_a?(Hash) && !(object.empty?))
      return process_array(object) if object.is_a?(Array)
      return process_string(object) if object.is_a?(String)
      []
    end

    def process_hash(object)
      categories = []
      object.each_pair do |key, value|
        # Remove the asterisk so we are just left with the name
        if key.start_with?('*')
          categories << key[1..-1]
          next
        end
        categories << key
        categories << process_category_item(value)
      end
      categories
    end

    def process_array(object)
      categories = []
      object.each do |item|
        categories << process_category_item(item)
      end
      categories
    end

    def process_string(object)
      object
    end
  end
end
