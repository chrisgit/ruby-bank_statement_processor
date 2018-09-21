using DateRefinements

describe DateRefinements do

  let (:leap_year) { 2016 }
  let (:year) { 2018 }
  # End of month
  it { expect(Date.end_of_month(Date.new(year, 1, 1))).to eq(Date.new(year, 1, 31)) }
  it { expect(Date.end_of_month(Date.new(year, 2, 1))).to eq(Date.new(year, 2, 28)) }
  it { expect(Date.end_of_month(Date.new(year, 3, 1))).to eq(Date.new(year, 3, 31)) }
  it { expect(Date.end_of_month(Date.new(year, 4, 1))).to eq(Date.new(year, 4, 30)) }
  it { expect(Date.end_of_month(Date.new(year, 5, 1))).to eq(Date.new(year, 5, 31)) }
  it { expect(Date.end_of_month(Date.new(year, 6, 1))).to eq(Date.new(year, 6, 30)) }
  it { expect(Date.end_of_month(Date.new(year, 7, 1))).to eq(Date.new(year, 7, 31)) }
  it { expect(Date.end_of_month(Date.new(year, 8, 1))).to eq(Date.new(year, 8, 31)) }
  it { expect(Date.end_of_month(Date.new(year, 9, 1))).to eq(Date.new(year, 9, 30)) }
  it { expect(Date.end_of_month(Date.new(year, 10, 1))).to eq(Date.new(year, 10, 31)) }
  it { expect(Date.end_of_month(Date.new(year, 11, 1))).to eq(Date.new(year, 11, 30)) }
  it { expect(Date.end_of_month(Date.new(year, 12, 1))).to eq(Date.new(year, 12, 31)) }

  it { expect(Date.end_of_month(Date.new(leap_year, 2, 1))).to eq(Date.new(leap_year, 2, 29)) }

  # Month Range
  it { expect(Date.month_range(year, 1)).to eq([Date.new(year, 1, 1), Date.new(year, 1, 31)]) }
  it { expect(Date.month_range(year, 2)).to eq([Date.new(year, 2, 1), Date.new(year, 2, 28)]) }
  it { expect(Date.month_range(year, 3)).to eq([Date.new(year, 3, 1), Date.new(year, 3, 31)]) }
  it { expect(Date.month_range(year, 4)).to eq([Date.new(year, 4, 1), Date.new(year, 4, 30)]) }
  it { expect(Date.month_range(year, 5)).to eq([Date.new(year, 5, 1), Date.new(year, 5, 31)]) }
  it { expect(Date.month_range(year, 6)).to eq([Date.new(year, 6, 1), Date.new(year, 6, 30)]) }
  it { expect(Date.month_range(year, 7)).to eq([Date.new(year, 7, 1), Date.new(year, 7, 31)]) }
  it { expect(Date.month_range(year, 8)).to eq([Date.new(year, 8, 1), Date.new(year, 8, 31)]) }
  it { expect(Date.month_range(year, 9)).to eq([Date.new(year, 9, 1), Date.new(year, 9, 30)]) }
  it { expect(Date.month_range(year, 10)).to eq([Date.new(year, 10, 1), Date.new(year, 10, 31)]) }
  it { expect(Date.month_range(year, 11)).to eq([Date.new(year, 11, 1), Date.new(year, 11, 30)]) }
  it { expect(Date.month_range(year, 12)).to eq([Date.new(year, 12, 1), Date.new(year, 12, 31)]) }

  it { expect(Date.month_range(leap_year, 2)).to eq([Date.new(leap_year, 2, 1), Date.new(leap_year, 2, 29)]) }

end