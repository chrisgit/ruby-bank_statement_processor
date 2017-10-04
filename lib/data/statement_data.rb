module BankStatements

  # Load all files in CSV folder
  class CSVBankData

    # statement_reader, category processor, query, summary
    def initialize(csv_folder: nil, csv_files: nil, category_processor: nil)
      @reader = CSVStatementReader.new(statement_folder: csv_folder, statement_files: csv_files)
      @reader.load_data()
      @category_processor = category_processor || HashCategory.new()
      apply_categories()
      @memory_query = MemoryQuery.new(transactions)
    end

    def transactions
      @reader.transactions
    end

    def query(start_date, end_date, type, category)
      @memory_query.query(start_date, end_date, type, category)
    end

    def categories
      @category_processor.info.to_a()
    end

    def transaction_year_span()
      @year_span ||= begin
        transactions.map { |t| t.date.year }.uniq
      end
    end

    # Static / Helpers
    def self.from_folder(csv_file_folder)
      CSVBankData.new(csv_folder: csv_file_folder)
    end

    def self.from_files(csv_file_list)
      CSVBankData.new(csv_files: csv_file_list)
    end

    private

    def apply_categories()
      transactions.each do |transaction|
        transaction.categories = @category_processor.process_category(transaction.description)
      end
    end

  end
end
