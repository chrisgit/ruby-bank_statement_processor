# Miscellaneous items also unmapped or incorrectly mapped
=begin
Report.for(:unmapped).run(Date.new(2000,1,1), Date.new(2099,12,31))
===================
Miscellaneous Items
===================

Date         Type   Description
2009-01-05   POS    Some Transcation that does not match
2009-02-23   BAC    Some Transcation that does not match
2009-04-23   CHQ    Some Transcation that does not match
2009-05-05   BGC    Some Transcation that does not match
2009-08-13   POS    Some Transcation that does not match
=end
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
