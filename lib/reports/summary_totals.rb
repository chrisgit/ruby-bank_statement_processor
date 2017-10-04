# Category totals (all years)
module BankStatements
  module Reports
    class SummaryTotals < BaseReport

      def initialize(statement_data = nil)
        statement_data ||= BankStatements::CSVBankData.new('.')
        @summary_service = SummaryService.new(statement_data)
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
