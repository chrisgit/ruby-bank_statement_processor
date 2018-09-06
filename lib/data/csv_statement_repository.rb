require_relative 'category/hash_categories'
require_relative 'category/direct_match_processor'
require_relative 'category/hash_category_processor'
require_relative 'category/personal_categories' if File.exist?(File.expand_path('category/personal_categories.rb', __dir__))
require_relative 'category/category_processors'
require_relative 'csv/csv_statement_reader'
require_relative 'csv/in_memory_query'

module BankStatements
  class CSVStatementRepository
    def initialize(folder)
      mapper = Model::TransactionMapper.new()
      @data = CSVStatementReader.new(folder).read do | row |
        transaction = mapper.map(row)
        transaction.categories = Processor.for(transaction.type).match(transaction.description)
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
