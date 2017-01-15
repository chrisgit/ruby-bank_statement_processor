# All categories by year (Pivot)
module BankStatements
  module Reports
    class SummaryByCategoryByYear < BaseReport

      def initialize(summary_service = nil)
        @summary_service = summary_service || BankStatements::SummaryService.new
      end

      def run()
        # Summary by category by year
        data = @summary_service.pivot_table
        return report_line('Nothing to display') if data.empty?
        heading('Summary By Category By Year')
        header_format = '%-25s' + (' %12s' * (data[0].length - 1))
        row_format = '%-25s' + (' %12.2f' * (data[0].length - 1))
        report_line(header_format % data[0])
        data[1..-1].each do |row|
          report_line(row_format % row)
        end
        blank_line
      end
    end
  end
end
