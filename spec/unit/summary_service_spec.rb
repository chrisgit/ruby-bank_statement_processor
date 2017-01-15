require 'spec_helper'
require 'data/summary_service_data'

describe 'SummaryService' do
  before(:each) do
    @bank_data = double()
    @category_processor = double()
  end

  describe '#balance_grand_total' do
    it 'calculates total paid in and total paid out for all available data' do
      allow(@bank_data).to receive(:transactions).and_return(ALL_SUMMARY_DATA)
      summary_service = BankStatements::SummaryService.new(@bank_data, @category_processor)
      expect(summary_service.balance_grand_total).to eq (Balance.new(989.24,674.97))
    end
  end

  describe '#balance_for_year' do
    it 'calculates total paid in and total paid out for a specified year' do
      start_date = Date.parse('01/01/2017')
      end_date = Date.parse('31/12/2017')
      allow(@bank_data).to receive(:query).with(start_date, end_date, nil, nil).and_return(PAYMENTS_IN_2017 + PAYMENTS_OUT_2017)
      summary_service = BankStatements::SummaryService.new(@bank_data, @category_processor)
      expect(summary_service.balance_for_year("2017")).to eq (Balance.new(596.13,356.46))
    end
  end
end
