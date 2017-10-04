# Record structure for bank transaction
Transaction = Struct.new(:date, :type, :description, :value, :account_name, :account_number, :categories)
