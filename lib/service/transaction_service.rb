# Transaction data retrieval
module BankStatements
  class TransactionService
    def initialize(bank_data = nil)
      @statement_data = bank_data || BankData.data()
    end

    def transactions
      @statement_data.transactions
    end

    def query(start_date = nil, end_date = nil, type = nil, categories = nil)
      @statement_data.query(start_date, end_date, type, categories)
    end
  end
end
