=begin
Report.for(:monthly_comparison).run(Date.new(2018,1,1), Date.new(2018,3,1))
==================
Monthly Comparison
==================

Category                                 January 2018   March 2018     Variance
Bills,Council Tax                             -XXX.XX        XX.XX      -XXX.XX
Bills,Mobile Phone                             -XX.XX       -XX.XX        XX.XX

Paid In:                                      XXXX.XX      XXXX.XX        XX.XX
Paid Out:                                    -XXXX.XX     -XXXX.XX        XX.XX
Balance:                                      -XXX.XX      -XXX.XX       XXX.XX
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
        transactions = [report_data(month1), report_data(month2)]
        categories = (transactions[0].keys + transactions[1].keys).uniq.sort
        return report_line('Nothing to display') if categories.empty?
        @consolidated ? heading('Monthly Comparison (consolidated)') : heading('Monthly Comparison')
        blank_line

        balance = [ Model::Balance.new, Model::Balance.new]
        # Add number of transactions?
        # Category Month 1 Month 2   Variance
        report_line(format('%-40s %-14s %-14s %-14s',
          'Category', "#{Date::MONTHNAMES[month1.month]} #{month1.year}",
          "#{Date::MONTHNAMES[month2.month]} #{month2.year}", 'Variance'))
        categories.each do |category|
          totals = [
            accumulate_category(transactions[0], category),
            accumulate_category(transactions[1], category)
          ]
          category_name = category.is_a?(Array) ? category.join(',') : category
          report_line(format('%-40s %12.2f %12.2f %12.2f',
            category_name[0..39], totals[0],
            totals[1], totals[0] - totals[1]))
          balance[0].accumulate(totals[0])
          balance[1].accumulate(totals[1])
        end
        blank_line
        report_line(format('%-40s %12.2f %12.2f %12.2f',
          'Paid In:', balance[0].paid_in, balance[1].paid_in,
          balance[0].paid_in - balance[1].paid_in))
        report_line(format('%-40s %12.2f %12.2f %12.2f',
          'Paid Out:', balance[0].paid_out, balance[1].paid_out,
          balance[0].paid_out - balance[1].paid_out))
        report_line(format('%-40s %12.2f %12.2f %12.2f',
          'Balance:', balance[0].balance, balance[1].balance,
          balance[0].balance - balance[1].balance))
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
