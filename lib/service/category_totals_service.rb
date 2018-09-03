# BankStatements - Summary Data
# Split into ... YearlySummary ... MonthlySummary ... Summary (Query)


# Change this to TotalService
module BankStatements
  class CategoryTotalsService

    def initialize(statement_repository, category_repository)
      @statement_repository = statement_repository
      @category_repository = category_repository
    end

    # Generic query
    def query(start_date = nil, end_date = nil, type = nil, categories = nil)
      transactions = @statement_repository.query(start_date, end_date, type, categories)
      return 0 if transactions.empty?
      transactions.map(&:value).inject(&:+).abs.round(2)
    end

    # Pivot table. Categories v Years
    # Group this by the categories
    def by_category_by_year
      date_range = @statement_repository.transaction_years()
      return [] if date_range.empty?
      rows = [(['Category'] << date_range).flatten]
      @category_repository.all.each do |category|
        category_by_year = []
        date_range.each do |year|
          start_date, end_date = Date.year_range(year)
          category_by_year << query(start_date, end_date, nil, category)
        end
        rows << ([category] << category_by_year).flatten
      end
      rows
    end
  end
end
