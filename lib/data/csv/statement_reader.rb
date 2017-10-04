module BankStatements

  class CSVStatementReader
    @data = nil

    attr_reader :transactions

    def initialize(statement_folder: nil, statement_files: nil)
      @statement_files = []
      @statement_files = resolve_folder(statement_folder) unless statement_folder.nil?
      @statement_files = resolve_files(statement_files) unless statement_files.nil?
    end

    def load_data()
      # If block given then execute for each row
      read_all_csv()
    end

    private

    def resolve_folder(statement_folder)
      statement_folder.gsub!('\\', '/')
      Dir["#{statement_folder}/*.csv"].map(&File.method(:realpath))
    end

    def resolve_files(statement_files)
      return statement_files if statement_files.is_a?(Array)
      return [statement_files] if statement_files.is_a?(String)
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
        row[:account_number])
    end

  end
end
