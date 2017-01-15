require 'spec_helper'
require 'support/nil_category_processor'
require 'data/query_category_data'

describe 'CSVBankData' do
  describe '#query' do
    describe 'transaction categories' do
      describe 'no category is specified' do
        it 'returns all data' do
          bank_data = BankStatements::CSVBankData.new([], NilCategoryProcessor.new)
          bank_data.instance_variable_set(:@transactions, ALL_CATEGORY_DATA)
          expect(bank_data.query(nil,nil,nil,nil)).to eq(ALL_CATEGORY_DATA)
        end
      end
      describe 'single category is specified' do
        it 'returns only data matching category' do
          bank_data = BankStatements::CSVBankData.new([], NilCategoryProcessor.new)
          bank_data.instance_variable_set(:@transactions, ALL_CATEGORY_DATA)
          expect(bank_data.query(nil,nil,nil,'Tesco')).to eq(DATE_2016_TESCO + DATE_2016_TESCO_PETROL)
        end
      end
      describe 'multiple categories are specified' do
        it 'returns data from specified categories' do
          bank_data = BankStatements::CSVBankData.new([], NilCategoryProcessor.new)
          bank_data.instance_variable_set(:@transactions, ALL_CATEGORY_DATA)
          expect(bank_data.query(nil,nil,nil,['Tesco', 'Petrol'])).to eq(DATE_2016_TESCO_PETROL)
        end
      end
      describe 'date range and type' do
        it 'returns data within the date range and category specified' do
          bank_data = BankStatements::CSVBankData.new([], NilCategoryProcessor.new)
          bank_data.instance_variable_set(:@transactions, ALL_CATEGORY_DATA)
          start_date = Date.parse('01/05/2016')
          end_date = Date.parse('31/08/2016')
          expect(bank_data.query(start_date,end_date,nil,'Misc')).to eq(DATE_2016_MISC_MID_YEAR)
        end
      end
    end
  end
end
