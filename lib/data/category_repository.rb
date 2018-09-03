require_relative 'category/hash_categories'
require_relative 'category/hash_category_info'
require_relative 'category/direct_match_processor'
require_relative 'category/hash_category_processor'
require_relative 'category/personal_categories' if File.exist?(File.expand_path('category/personal_categories.rb', __dir__))
require_relative 'category/category_processors'

module BankStatements
  class CategoryRepository
    def categories
      BankStatements::HashCategories::CATEGORIES
    end

    def all
      @info ||= HashCategoryInfo.new(categories)
      @info.to_a()
    end

    def top_level
      categories.keys
    end
  end
end
