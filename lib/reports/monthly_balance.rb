=begin
Report.for(:monthly_balance).run(Date.new(2018,1,1), Date.new(2018,4,30))
===============
Monthly Balance
===============

January 2018         Paid In:   XXX.XX      Paid Out:  -XXX.XX     Balance:   -XXX.XX
February 2018        Paid In:   XXX.XX      Paid Out:  -XXX.XX     Balance:   -XXX.XX
March 2018           Paid In:   XXX.XX      Paid Out:  -XXX.XX     Balance:   -XXX.XX
April 2018           Paid In:   XXX.XX      Paid Out:  -XXX.XX     Balance:   -XXX.XX

Grand Total
Paid In:       XXXX.XX
Paid Out:     -XXXX.XX
Balance:        -XX.XX
=end
module BankStatements
  module Reports
    class MonthlyBalance < BaseReport

      def initialize(statement_repository)
        @statement_repository = statement_repository
      end

      def run(start_date, end_date)
        start_date = Date.new(start_date.year, start_date.month, 1)
        end_date = Date.end_of_month(end_date)
        transactions = @statement_repository.query(start_date, end_date, nil, nil).group_by {|t| [t.date.year, t.date.month]}
        return report_line('Nothing to display') if transactions.empty?
        heading('Monthly Balance')
        blank_line
        grand_total = Model::Balance.new
        transactions.keys.sort.each do |year_month|
          balance = Model::Balance.new
          transactions[year_month].each do |t|
            balance.accumulate(t.value)
            grand_total.accumulate(t.value)
          end
          report_line(format('%-20s %-10s %-12.2f %-10s %-12.2f %-10s %-12.2f',
            "#{Date::MONTHNAMES[year_month[1]]} #{year_month[0]}",
            'Paid In:', balance.paid_in,
            'Paid Out:', balance.paid_out,
            'Balance:', balance.balance))
        end
        blank_line
        report_line('Grand Total')
        report_line(format("%-10s %12.2f", "Paid In:", grand_total.paid_in))
        report_line(format("%-10s %12.2f", "Paid Out:", grand_total.paid_out))
        report_line(format("%-10s %12.2f", "Balance:", grand_total.balance))
    end
    end
  end
end
