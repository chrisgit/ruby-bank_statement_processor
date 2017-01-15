# BankStatements - Summary Data
# Split into ... YearlySummary ... MonthlySummary ... Summary (Query)
module BankStatements
  class SummaryService

    def initialize(bank_data = nil, category_info = nil)
      @statement_data = bank_data || BankData.data()
      @category_info = category_info || Category.category_processor()
    end

    # Create summary of all transaction
    def balance_grand_total
      balance = Balance.new(0.0,0.0)
      @statement_data.transactions.each do |t|
        add_value_to_balance(balance, t.value)
      end
      Balance.new(balance.paid_in.round(2), balance.paid_out.abs.round(2))
    end

    # Create for each year
    def balance_for_year(year)
      start_date, end_date = create_date_range_for_year(year)
      balance = Balance.new(0.0,0.0)
      @statement_data.query(start_date, end_date, nil, nil).each do |t|
        add_value_to_balance(balance, t.value)
      end
      Balance.new(balance.paid_in.round(2), balance.paid_out.abs.round(2))
    end

    # Create for each year
    def balance_for_all_years
      year_range = @statement_data.transaction_year_span()
      return [] if year_range.empty?
      balance = {}
      year_range.each do |year|
        balance[year] = balance_for_year(year)
      end
      balance
    end

    # Summary total for all categories all years
    def grand_total_all_categories
      category_totals = {}
      @category_info.to_a.each do |category|
        summary_value = query(nil,nil,nil,category)
        category_totals[category] = summary_value
      end
      category_totals
    end

    # For everything else
    def query(start_date = nil, end_date = nil, type = nil, categories = nil)
      transactions = @statement_data.query(start_date, end_date, type, categories)
      return 0 if transactions.empty?
      transactions.map(&:value).inject(&:+).abs.round(2)
    end

    # Pivot table. Categories v Years
    def pivot_table()
      date_range = @statement_data.transaction_year_span()
      return [] if date_range.empty?
      rows = [(['Category'] << date_range).flatten]
      @category_info.to_a.each do |category|
        category_by_year = []
        date_range.each do |year|
          start_date, end_date = create_date_range_for_year(year)
          category_by_year << query(start_date, end_date, nil, category)
        end
        rows << ([category] << category_by_year).flatten
      end
      rows
    end

    private

    def add_value_to_balance(balance, value)
      if value > 0
        balance.paid_in += value
      else
        balance.paid_out += value
      end
    end

    def create_date_range_for_year(year)
      return DateTime.parse("01/01/#{year}"), DateTime.parse("31/12/#{year}")
    end

  end
end

# Grand Total
=begin
# Multiple passes
  summary = Summary.new(0.0,0.0)
  summary.paid_in = @transactions.map { |t| t.value > 0 ? t.value : 0.00}.inject(&:+).round(2)
  summary.paid_out = @transactions.map { |t| t.value < 0 ? t.value : 0.00}.inject(&:+).round(2).abs
  
# Single loop
    # Create summary of all transaction
    summary = Summary.new(0.0,0.0)
    statement_data.transactions.each do |t|
      if t.value > 0
        summary.paid_in = summary.paid_in + t.value
      else
        summary.paid_out = summary.paid_out + t.value
      end
    end
    Summary.new (summary.paid_in.round(2), summary.paid_out.round(2).abs)

=end
