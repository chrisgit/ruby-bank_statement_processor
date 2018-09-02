# All categories by year (Pivot)
module BankStatements
  module Reports
    class MonthlySpend < BaseReport

      def initialize(monthly_spend_service)
        @service = monthly_spend_service
      end

      def run(year, month)
        # Summary by category by year
        data = @service.for_month(year, month)
        return report_line('Nothing to display') if data.empty?
        heading('Monthly Spend')
        blank_line
        #balance = Model::Balance.new(0.0, 0.0)
        report_line(format('%-25s %12s' % ['Category', 'Total Value']))
        data.each do |category, total_value|
          report_line(format('%-25s %12.2f' % [category, total_value]))
        #  balance.accumulate(total_value)
        end
        #report_line("Paid In: #{balance.paid_in}")
        #report_line("Paid Out: #{balance.paid_out}")
        blank_line
      end
    end
  end
end
