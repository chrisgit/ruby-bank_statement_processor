# All categories by year (Pivot)
module BankStatements
  module Reports
    class CategoryByYear < BaseReport

      def initialize(statement_repository)
        @statement_repository = statement_repository
      end

      def run()
        # Summary by category by year
        data = report_data
        return report_line('Nothing to display') if data.empty?
        heading('Summary By Category By Year')
        header_format = '%-35s' + (' %12s' * (data[0].length - 1))
        row_format = '%-35s' + (' %12.2f' * (data[0].length - 1))
        report_line(header_format % data[0])
        data[1..-1].each do |row|
          report_line(row_format % row)
        end
        blank_line
      end

      private

      # Returns an array of arrays, first row is heading i.e. "Category", "Year", "Year", "Year"
      def report_data
        transactions = @statement_repository.query(nil,nil,nil,nil).group_by { |t| [t.date.year, t.categories[0] ] }
        year_span = transactions.keys.map {|key| key[0]}.uniq.sort
        categories = transactions.keys.map {|key| key[1]}.uniq.sort
        rows = [(['Category'] << year_span).flatten]
        categories.each do |category|
          category_by_year = []
          year_span.each do |year|
            if transactions[[year, category]].nil?
              value = 0.0
            else
              value = transactions[[year, category]].map(&:value).inject(&:+).abs.round(2)
            end
            category_by_year << value
          end
          rows << ([category] << category_by_year).flatten
        end
        rows
      end
    end
  end
end
