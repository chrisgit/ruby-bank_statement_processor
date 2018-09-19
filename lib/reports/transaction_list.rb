=begin
Report.for(:transaction_list).run(Date.new(2018,1,1), Date.new(2018,1,31), 'D/D', nil)
================
Transaction List
================

Date          Type  Description                                                         Value
2018-01-02     D/D  PENSION                                                            -XX.XX
2018-01-04     D/D  CAR MEMBERSHIP                                                    -XXX.XX
2018-01-05     D/D  COUNCIL                                                           -XXX.XX
2018-01-05     D/D  INSURANCE                                                         -XXX.XX
=end
module BankStatements
  module Reports
    class TransactionList < BaseReport

      def initialize(statement_repository)
        @statement_repository = statement_repository
      end

      def run(start_date, end_date, type, categories)
        transactions = @statement_repository.query(start_date, end_date, type, categories).sort_by {|t| t.date}
        return report_line('Nothing to display') if transactions.empty?
        heading('Transaction List')
        blank_line
        report_line(format('%-10s  %6s  %-60s  %12s', 'Date', 'Type', 'Description', 'Value'))
        grand_total = Model::Balance.new
        transactions.each do |transaction|
          report_line(format('%10s  %6s  %-60s  %12.2f',
            transaction.date,
            transaction.type,
            transaction.description[0..59],
            transaction.value))
            grand_total.accumulate(transaction.value)
        end
        blank_line
        report_line('Total:')
        report_line(format("%-10s %12.2f", "Paid In:", grand_total.paid_in))
        report_line(format("%-10s %12.2f", "Paid Out:", grand_total.paid_out))
        report_line(format("%-10s %12.2f", "Balance:", grand_total.balance))
      end
    end
  end
end
