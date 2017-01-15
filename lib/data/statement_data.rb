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

    def query(start_date, end_date, type, category)
      start_date = Date.parse('01/02/1901') if start_date.nil?
      end_date = Date.parse('31/12/2099') if end_date.nil?
      match_type = normalize_to_array(type)
      match_categories = normalize_to_array(category)
      @transactions.select do | transaction |
        query_matcher(start_date, end_date, match_type, match_categories, transaction)
      end
    end

    def transaction_year_span()
      @transactions.map { |t| t.date.year }.uniq
    end

    private

    def query_matcher(start_date, end_date, match_type, match_categories, transaction)
      match = transaction.date >= start_date && transaction.date <= end_date
      match &&= (match_type.include?(transaction.type)) unless match_type.empty?
      match &&= ((transaction.categories & match_categories).length == match_categories.length)
      match
    end

    def normalize_to_array(value)
      return value if value.is_a?(Array)
      return [value] if value.is_a?(String)
      []
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
  end
end
