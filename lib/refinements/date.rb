require 'date'

class Date
  def self.end_of_month(year, month)
    Date.new(year, month, 1).next_month.prev_day
  end

  def self.month_range(year, month)
    start_of_month = Date.new(year, month, 1)
    end_of_month = Date.end_of_month(year, month)
    return start_of_month, end_of_month
  end

  def self.year_range(year)
    start_of_year = Date.new(year, 1, 1)
    end_of_month = Date.end_of_month(year, 12)
    return start_of_month, end_of_month
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