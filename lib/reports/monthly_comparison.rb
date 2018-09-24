=begin
Report.for(:monthly_comparison).run(Date.new(2018,1,1), Date.new(2018,3,1))
=============
Monthly Comp
=============

Total Value     Categories
    -XXX.00    Bills,Council Tax
     -XX.00    Bills,Mobile Phone

Paid In:        XXXX.XX
Paid Out:      -XXXX.XX
Balance:        -XXX.XX
=end
require_relative '../refinements/date'
using DateRefinements

module BankStatements
  module Reports
    class MonthlyComparison < BaseReport

      def initialize(statement_repository, consolidated)
        @statement_repository = statement_repository
        @consolidated = consolidated
      end

      def run(month1, month2)
        month1_transactions = report_data(month1)
        month2_transactions = report_data(month2)
        categories = (month1_transactions.keys + month2_transactions.keys).uniq.sort
        return report_line('Nothing to display') if categories.empty?
        @consolidated ? heading('Monthly Comparison (consolidated)') : heading('Monthly Comparison')
        blank_line

        month1_balance = Model::Balance.new
        month2_balance = Model::Balance.new
        # Add number of transactions?
        # Category Month 1 Month 2   Variance
        report_line(format('%-40s %-14s %-14s %-14s',
          'Category', "#{Date::MONTHNAMES[month1.month]} #{month1.year}",
          "#{Date::MONTHNAMES[month2.month]} #{month2.year}", 'Variance'))
        categories.each do |category|
          total_month1 = accumulate_category(month1_transactions, category)
          total_month2 = accumulate_category(month2_transactions, category)

          category_name = category.is_a?(Array) ? category.join(',') : category
          report_line(format('%-40s %12.2f %12.2f %12.2f',
            category_name[0..39], total_month1,
            total_month2, total_month1 - total_month2))
          month1_balance.accumulate(total_month1)
          month2_balance.accumulate(total_month2)
        end
        blank_line
        report_line(format('%-40s %12.2f %12.2f %12.2f',
          'Paid In:', month1_balance.paid_in, month2_balance.paid_in,
          month1_balance.paid_in - month2_balance.paid_in))
        report_line(format('%-40s %12.2f %12.2f %12.2f',
          'Paid Out:', month1_balance.paid_out, month2_balance.paid_out,
          month1_balance.paid_out - month2_balance.paid_out))
        report_line(format('%-40s %12.2f %12.2f %12.2f',
          'Balance:', month1_balance.balance, month2_balance.balance,
          month1_balance.balance - month2_balance.balance))
        blank_line
      end

      private

      def report_data(reference_date)
        start_date, end_date = Date.month_range(reference_date.year, reference_date.month)
        group_block = @consolidated ? lambda{|t| t.categories[0]} : lambda{|t| t.categories}
        @statement_repository.query(start_date, end_date, nil, nil).group_by(&group_block)
      end

      def accumulate_category(transactions, category)
        return 0.00 unless transactions.key?(category)
        transactions[category].map(&:value).inject(&:+).round(2)
      end
    end
  end
end
