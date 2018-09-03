# All categories by year (Pivot)
module BankStatements
  module Reports
    class MonthlySpend < BaseReport

      def initialize(statement_repository)
        @statement_repository = statement_repository
      end

      def run(start_date, end_date)
        transactions = @statement_repository.query(start_date, end_date, nil, nil).group_by(&:categories).sort
        return report_line('Nothing to display') if transactions.empty?
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
    end
  end
end
