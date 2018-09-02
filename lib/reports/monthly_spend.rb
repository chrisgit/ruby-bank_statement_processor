# All categories by year (Pivot)
module BankStatements
  module Reports
    class MonthlySpend < BaseReport

      def initialize(statement_repository)
        @statement_repository = statement_repository
      end

      # Lazy implimentation in order to get figures out quickly; change to accept date range (and categories?)
      def run(year, month)
        start_date, end_date = start_end_dates(year, month)
        transactions = @statement_repository.query(start_date, end_date, nil, nil).group_by(&:categories).sort
        #transactions = @statement_repository.query(Date.new(year, month, 1), Date.end_of_month(year, month), nil, nil).group_by(&:categories).sort
        return report_line('Nothing to display') if transactions.empty?
        #grouped_transactions = transactions.group_by {|t| t.categories}.sort
        heading('Monthly Spend')
        blank_line
        balance = Model::Balance.new
        # Add number of transactions?
        report_line(format('%-15s %-40s' % ['Total Value', 'Categories']))
        transactions.each do |category_group|
          categories = category_group[0]
          items = category_group[1]
          total_value = items.map(&:value).inject(&:+).round(2)
          report_line(format('%11.2f    %-40s' % [total_value, categories.join(',')]))
          balance.accumulate(total_value)
        end
        blank_line
        report_line(format("%-10s %12.2f", "Paid In:", balance.paid_in))
        report_line(format("%-10s %12.2f", "Paid Out:", balance.paid_out))
        report_line(format("%-10s %12.2f", "Balance:", balance.balance))
        blank_line
      end

      private

      def start_end_dates(year, month)
        return Date.new(1900, 1, 1), Date.end_of_month(2099, 12) if year.nil?
        return Date.new(year, 1, 1), Date.end_of_month(year,12) if month.nil?
        return Date.new(year, month, 1), Date.end_of_month(year, month)
      end
    end
  end
end
