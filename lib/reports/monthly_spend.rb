=begin
Report.for(:monthly_spend).run(Date.new(2018,1,1), Date.new(2018,1,31))
=============
Monthly Spend
=============

Total Value     Categories
    -XXX.00    Bills,Council Tax
     -XX.00    Bills,Mobile Phone

Paid In:        XXXX.XX
Paid Out:      -XXXX.XX
Balance:        -XXX.XX
=end
module BankStatements
  module Reports
    class MonthlySpend < BaseReport

      def initialize(statement_repository, consolidated)
        @statement_repository = statement_repository
        @consolidated = consolidated
      end

      def run(start_date, end_date)
        transactions = report_data(start_date, end_date)
        return report_line('Nothing to display') if transactions.empty?
        @consolidated ? heading('Monthly Spend (consolidated)') : heading('Monthly Spend')
        blank_line
        balance = Model::Balance.new
        # Add number of transactions?
        report_line(format('%-13s %-40s' % ['Total Value', 'Categories']))
        transactions.each do |category_group|
          categories = category_group[0].is_a?(Array) ? category_group[0].join(',') : category_group[0]
          items = category_group[1]
          total_value = items.map(&:value).inject(&:+).round(2)
          report_line(format('%11.2f   %-40s', total_value, categories))
          balance.accumulate(total_value)
        end
        blank_line
        report_line(format('%-10s %12.2f', 'Paid In:', balance.paid_in))
        report_line(format('%-10s %12.2f', 'Paid Out:', balance.paid_out))
        report_line(format('%-10s %12.2f', 'Balance:', balance.balance))
        blank_line
      end

      private

      def report_data(start_date, end_date)
        group_block = @consolidated ? lambda{|t| t.categories[0]} : lambda{|t| t.categories}
        @statement_repository.query(start_date, end_date, nil, nil).group_by(&group_block).sort
      end
    end
  end
end
