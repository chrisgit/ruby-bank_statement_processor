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
      balance = Model::Balance.new
      @statement_repository.query(nil,nil,nil,nil).each do |t|
        balance.accumulate(t.value)
      end
      balance
    end

    # Create for each year
    def total_between_dates(start_date, end_date)
      balance = Model::Balance.new
      @statement_repository.query(start_date, end_date, nil, nil).each do |t|
        balance.accumulate(t.value)
      end
      balance
    end
  end
end
