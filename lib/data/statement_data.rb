module BankStatements

  class BankData
    @data = nil

    # Simple accessor for CSV bank data, could turn into factory
    class <<self
      attr_reader :statement_files

      def statement_files=(csv_file_folder)
        @statement_files = Dir["#{csv_file_folder}/*.csv"].map(&File.method(:realpath))
      end
    end

    def self.data
      @data ||= begin
        BankStatements::CSVBankData.new(statement_files)
      end
    end
  end

  # Load all files in CSV folder
  class CSVBankData

    attr_reader :transactions

    def initialize(statement_files = nil, category_processor = nil)
      @statement_files = statement_files || []
      @category_processor = category_processor || Category.category_processor()
      read_all_csv()
    end

  # Multiple category values 
  # http://stackoverflow.com/questions/25840356/array-include-multiple-values
  # Match any of the following
  # select { |t| (t.categories & ['Supermarket', 'Petrol']).any? }
  # Match ALL of the categories
  # categories_to_match = ['Supermarket', 'Petrol']
  # select { |t| (t.categories & categories_to_match).length == categories_to_match.length
    def query(start_date, end_date, type, category)
      matchers = querymatchers(start_date, end_date, type, category)
      @transactions.select do | transaction |
        matchers.all? { |m| m.match(transaction) }
      end
    end

    def transaction_year_span()
      @year_span ||= begin
        @transactions.map { |t| t.date.year }.uniq
      end
    end

    private

    # Only return required matchers
    def querymatchers(start_date, end_date, type, category)
      matchers = []
      matchers << QueryDateMatcher.new(start_date, end_date) unless start_date.nil? && end_date.nil?
      matchers << QueryTypeMatcher.new(type) unless type.nil?
      matchers << QueryCategoryMatcher.new(category) unless category.nil?
      matchers
    end

    # Return all matchers even if not required
    def allquerymatchers(start_date, end_date, type, category)
      [
        QueryDateMatcher.new(start_date, end_date),
        QueryTypeMatcher.new(type),
        QueryCategoryMatcher.new(category)
      ]
    end

    def read_all_csv()
      @transactions = []
      @statement_files.each do |filename|
        CSV.read(filename, headers: true, skip_blanks: true, header_converters: [:trim_header, :symbol], :converters => :all).each do |row|
          transaction = create_transaction(row)
          @transactions << transaction
        end
      end
    end

    def create_transaction(row)
      Transaction.new(
        Date.parse(row[:date]),
        row[:type],
        row[:description],
        row[:value],
        row[:account_name],
        row[:account_number],
        @category_processor.process_category(row[:description]))
    end

    private_constant

    class QueryDateMatcher
      def initialize(start_date,end_date)
        @start_date = start_date || Date.parse('01/02/1901')
        @end_date = end_date || Date.parse('31/12/2099')
      end

      def match(transaction)
        transaction.date >= @start_date && transaction.date <= @end_date
      end
    end

    class QueryTypeMatcher
      def initialize(match_type)
        @match_type = match_type if match_type.is_a?(Array)
        @match_type = [match_type] if match_type.is_a?(String)
        @match_type ||= []
      end

      def match(transaction)
        @match_type.include?(transaction.type) || @match_type.empty?
      end
    end

    class QueryCategoryMatcher
      def initialize(categories)
        @match_categories = categories if categories.is_a?(Array)
        @match_categories = [categories] if categories.is_a?(String)
        @match_categories ||= []
      end

      def match(transaction)
        (transaction.categories & @match_categories).length == @match_categories.length
      end
    end
  end
end
