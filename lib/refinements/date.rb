require 'date'

module DateRefinements
  refine Date.singleton_class do
    def end_of_month(date)
      Date.new(date.year, date.month, 1).next_month.prev_day
    end

    def month_range(year, month)
      start_of_month = Date.new(year, month, 1)
      end_of_month = start_of_month.next_month.prev_day
      return start_of_month, end_of_month
    end
  end
end
