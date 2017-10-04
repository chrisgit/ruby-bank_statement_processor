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
  