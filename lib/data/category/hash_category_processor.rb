module BankStatements
  class HashCategoryProcessor

    def initialize(category_hash, default = nil)
      @category_hash = category_hash
      @default = default || ['Misc']
      @hash_info = HashCategoryInfo.new(@category_hash, @default)
    end

    def match(description)
      categories = process_category_item(@category_hash, description)
      categories = categories.flatten.uniq
      return @default if categories.empty?
      categories
    end

    def keys
      @hash_info.keys
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

    class HashCategoryInfo
      def initialize(category_hash, default)
        @category_hash = category_hash
        @default = default
      end

      def keys()
        categories = process_category_item(@category_hash)
        categories << @default
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

    private_constant :HashCategoryInfo
  end
end

# Sainsburys supermarkets SAINSBURYS S/MKTS, SAINSBURYS, SAINSBURY'S SMKT
# Sainsburys petrol SAINSBURYS PETROL
# Sainsburys (ATM) SAINSBURYS B
# Tesco TESCO STORES, TESCO EXPRESS, TESCO UPT, TESCO SACAT, TESCO GARAGE, TESCO PETROL
# Tesco mobile TESCO MOBILE
# Wildlife HIOW WILDLIFE TRUS
# L&G medical LEGAL AND GEN MI C/L
# Post Office POST OFFICE
# Halfords  HALFORDS
# Morrisons MORRISONS, W M MORRISON
