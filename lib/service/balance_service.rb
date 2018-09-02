# BankStatements - Summary Data
# Split into ... YearlySummary ... MonthlySummary ... Summary (Query)
module BankStatements
  class BalanceService
    # using DateRefinements

    def initialize(statement_repository)
      @statement_repository = statement_repository
    end

    # Create summary of all transaction
    def grand_total
      balance = Model::Balance.new(0.0,0.0)
      @statement_repository.query(nil,nil,nil,nil).each do |t|
        balance.accumulate(t.value)
      end
      balance
    end

    # Create for each year
    def total_for_year(year)
      start_date, end_date = Date.year_range(year)
      balance = Model::Balance.new(0.0,0.0)
      @statement_repository.query(start_date, end_date, nil, nil).each do |t|
        balance.accumulate(t.value)
      end
      balance
    end

    # Refactor and iterate through items once
    def total_by_year
      year_range = @statement_repository.transaction_years()
      return [] if year_range.empty?
      balance = {}
      year_range.each do |year|
        balance[year] = total_for_year(year)
      end
      balance
    end
  end
end
