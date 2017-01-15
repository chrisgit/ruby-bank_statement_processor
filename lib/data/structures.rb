# Structure with some logic to manipulate cookbooks (rather than deal with Hashes)
Transaction = Struct.new(:date, :type, :description, :value, :account_name, :account_number, :categories)

Balance = Struct.new(:paid_in, :paid_out) do
  def initialize(paid_in = 0, paid_out = 0)
    super
  end

  def balance
    (paid_in - paid_out).round(2)
  end

  def to_map
    map = super
    map[:balance] = balance
    map
  end
end
