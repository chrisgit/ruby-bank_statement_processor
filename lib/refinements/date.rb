require 'date'

class Date
  def self.end_of_month(date)
    Date.new(date.year, date.month, 1).next_month.prev_day
  end

  def self.month_range(year, month)
    start_of_month = Date.new(year, month, 1)
    end_of_month = Date.end_of_month(Date.new(year, month, 1))
    return start_of_month, end_of_month
  end

  def self.year_range(year)
    start_of_year = Date.new(year, 1, 1)
    end_of_year = Date.end_of_month(Date.new(year, 12, 1))
    return start_of_year, end_of_year
  end
end

=begin
module DateRefinements
  refine Date do
    def self.month_range(year, month)
      start_of_month = Date.new(year, month, 1)
      end_of_month = start_of_month.next_month.prev_day
      return start_of_month, end_of_month
    end
  end
end
=end