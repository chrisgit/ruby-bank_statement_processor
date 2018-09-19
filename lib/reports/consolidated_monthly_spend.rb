=begin
Report.for(:consolidated_monthly_spend).run(Date.new(2018,1,1), Date.new(2018,1,31))
======================================
Consolidated Monthly Spend (unordered)
======================================

Total Value     Top Level Category
   -XXX.XX      Bills
    -XX.XX      Car
    -XX.XX      Cash / ATM withdrawal
=end
module BankStatements
  module Reports
    class ConsolidatedMonthlySpend < BaseReport

      def initialize(statement_repository)
        @statement_repository = statement_repository
      end

      def run(start_date, end_date)
        transactions = @statement_repository.query(start_date, end_date, nil, nil).group_by{|t| t.categories[0]}.sort
        return report_line('Nothing to display') if transactions.empty?
        heading('Consolidated Monthly Spend (unordered)')
        blank_line
        balance = Model::Balance.new
        # Add number of transactions?
        report_line(format('%-15s %-40s' % ['Total Value', 'Top Level Category']))
        transactions.each do |category_group|
          category = category_group[0]
          items = category_group[1]
          total_value = items.map(&:value).inject(&:+).round(2)
          report_line(format('%11.2f    %-40s' % [total_value, category]))
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
