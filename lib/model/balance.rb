module Model
  Balance = Struct.new(:paid_in, :paid_out) do
    def initialize(paid_in = 0, paid_out = 0)
      super
    end

    def accumulate(value)
      return if value.nil?
      if value > 0
        self.paid_in += value
      else
        self.paid_out += value
      end
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
end