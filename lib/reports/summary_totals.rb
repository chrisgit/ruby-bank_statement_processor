# Category totals (all years)
module BankStatements
  module Reports
    class SummaryTotals < BaseReport

      def initialize(summary_service = nil)
        @summary_service = summary_service || BankStatements::SummaryService.new
      end

      def run()
        data = @summary_service.grand_total_all_categories
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
