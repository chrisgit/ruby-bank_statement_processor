# Miscellaneous items also unmapped or incorrectly mapped
module BankStatements
  module Reports
    class MiscellaneousItems < BaseReport

      def initialize(statement_repository)
        @statement_repository = statement_repository
      end

      def run(start_date, end_date)
        transactions = @statement_repository.query(start_date, end_date, nil, 'Misc')
        return report_line('Nothing to display') if transactions.empty?
        heading('Miscellaneous Items')
        blank_line
        report_line(format('%-12s %-6s %-40s', 'Date', 'Type', 'Description'))
        transactions.each do |trn|
          report_line(format('%-12s %-6s %-40s', trn.date, trn.type, trn.description))
        end
        blank_line
      end
    end
  end
end
