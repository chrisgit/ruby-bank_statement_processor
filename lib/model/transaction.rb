# Record structure for bank transaction
module Model
  Transaction = Struct.new(:date, :type, :description, :value, :account_name, :account_number, :categories)

  class TransactionMapper
    def map(row)
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