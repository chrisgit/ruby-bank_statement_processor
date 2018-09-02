require_relative 'csv/csv_statement_reader'
require_relative 'csv/in_memory_query'
require_relative 'category_repository'

module BankStatements
  class CSVStatementRepository
    def initialize(folder)
      mapper = Model::TransactionMapper.new()
      category_repository = CategoryRepository.new()
      @data = CSVStatementReader.new(folder).read do | row |
        transaction = mapper.map(row)
        transaction.categories = category_repository.match(transaction.description)
        transaction
      end
    end

    # Possibly add query specification and query objects
    def query(start_date, end_date, type, categories)
      InMemoryQuery.new(@data).query(start_date, end_date, type, categories)
    end

    # Move to query object?
    def transaction_years()
      @year_span ||= begin
        @data.map { |t| t.date.year }.uniq
      end
    end
  end
end
