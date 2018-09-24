=begin
Report.for(:category_by_month).run(2018)
===================================
Summary By Category By Month (2018)
===================================
Category                                 January         February         March        April
Accomodation                                X.XX             X.XX        XXX.XX       XXX.XX
Bank                                        X.XX             X.XX        XXX.XX       XXX.XX
Bills                                       X.XX             X.XX        XXX.XX       XXX.XX
=end
module BankStatements
  module Reports
    class CategoryByMonth < BaseReport

      def initialize(statement_repository, consolidated)
        @statement_repository = statement_repository
        @consolidated = consolidated
      end

      def run(year)
        # Summary by category by year
        data = report_data(year)
        return report_line('Nothing to display') if data.empty?
        heading("Summary By Category By Month (#{year})")
        if @consolidated
          header_format = '%-30s' + (' %12s' * (data[0].length - 1))
          row_format = '%-30s' + (' %12.2f' * (data[0].length - 1))
        else
          header_format = '%-45s' + (' %12s' * (data[0].length - 1))
          row_format = '%-45s' + (' %12.2f' * (data[0].length - 1))
        end
        report_line(header_format % data[0])
        data[1..-1].each do |row|
          report_line(row_format % row)
        end
        blank_line
      end

      #private

      def report_data(year)
        start_date = Date.new(year,1,1)
        end_date = Date.new(year,12,31)
        group_block = @consolidated ? lambda { |t| [t.categories[0], t.date.month] } : lambda { |t| [t.categories, t.date.month] }
        transactions = @statement_repository.query(start_date,end_date,nil,nil).group_by(&group_block)
        categories = transactions.keys.map {|key| key[0]}.uniq.sort
        month_names = (1..12).each.map {|m| Date::MONTHNAMES[m] }
        rows = [(['Category'] + month_names)]
        categories.each do |category|
          category_by_month = category.is_a?(Array) ? [category.join(',')] : [category]
          (1..12).each do |process_month|
            value = 0.00
            if transactions.key?([category, process_month])
              value = transactions[[category, process_month]].map(&:value).inject(&:+).abs.round(2)
            end
            category_by_month << value
          end
          rows << category_by_month
        end
        rows
      end
    end
  end
end
