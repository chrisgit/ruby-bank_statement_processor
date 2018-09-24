=begin
Report.for(:category_by_year).run()
===========================
Summary By Category By Year
===========================
Category                                    2009         2010         2011         2012
Accomodation                                X.XX         X.XX       XXX.XX       XXX.XX
Bank                                        X.XX         X.XX       XXX.XX       XXX.XX
Bills                                       X.XX         X.XX       XXX.XX       XXX.XX
=end
module BankStatements
  module Reports
    class CategoryByYear < BaseReport

      def initialize(statement_repository, consolidated)
        @statement_repository = statement_repository
        @consolidated = consolidated
      end

      def run()
        # Summary by category by year
        data = report_data
        return report_line('Nothing to display') if data.empty?
        heading('Summary By Category By Year')
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

      private

      # Returns an array of arrays, first row is heading i.e. "Category", "Year", "Year", "Year"
      def report_data
        group_block = @consolidated ? lambda { |t| [t.date.year, t.categories[0]] } : lambda { |t| [t.date.year, t.categories] }
        transactions = @statement_repository.query(nil,nil,nil,nil).group_by(&group_block)
        year_span = transactions.keys.map {|key| key[0]}.uniq.sort
        categories = transactions.keys.map {|key| key[1]}.uniq.sort
        rows = [(['Category'] << year_span).flatten]
        categories.each do |category|
          category_by_year = category.is_a?(Array) ? [category.join(',')] : [category]
          year_span.each do |year|
            value = 0.00
            if transactions.key?([year, category])
              value = transactions[[year, category]].map(&:value).inject(&:+).abs.round(2)
            end
            category_by_year << value
          end
          rows << category_by_year
        end
        rows
      end
    end
  end
end
