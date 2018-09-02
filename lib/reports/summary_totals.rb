# Category totals (all years)
module BankStatements
  module Reports
    class SummaryTotals < BaseReport

      def initialize(category_totals_service)
        @category_totals_service = category_totals_service
      end

      def run()
        data = @category_totals_service.all_categories_all_years
        return report_line('Nothing to display') if data.empty?
        heading('Summary By Category')
        blank_line
        report_line(format('%-25s %12s' % ['Category', 'Total Value']))
        data.each do |category, total_value|
          report_line(format('%-25s %12.2f' % [category, total_value]))
        end
        blank_line
      end
    end
  end
end
