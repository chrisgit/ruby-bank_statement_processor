require 'date'

# BankStatements - Summary Data
module BankStatements
  class MonthlySpendService
    # using DateRefinements

    def initialize(statement_repository)
      @statement_repository = statement_repository
    end

    # Create for each year
    def for_month(year, month)
      start_date, end_date = Date.month_range(year, month)
      # Get transactions
      # Push all this to repository?
      transactions = @statement_repository.query(start_date, end_date, nil, nil)
      categories = unique_categories(transactions)
      total_by_categories = {}
      categories.each do |category|
        category_value = transactions.select {|t| t.categories.include?(category) }.map(&:value).inject(&:+).round(2)
        total_by_categories[category] = category_value
      end
      total_by_categories
    end

    private

    def unique_categories(transactions)
      categories = transactions.map { |t| t.categories }.flatten.uniq
    end
  end
end
