require 'spec_helper'
require 'support/nil_category_processor'
require 'data/query_type_data'

describe 'CSVBankData' do
  describe '#query' do
    describe 'transaction types' do
      describe 'no type is specified' do
        it 'returns all data' do
          bank_data = BankStatements::CSVBankData.new([], NilCategoryProcessor.new)
          bank_data.instance_variable_set(:@transactions, ALL_TYPE_DATA)
          expect(bank_data.query(nil,nil,nil,nil)).to eq(ALL_TYPE_DATA)
        end
      end
      describe 'single type is specified' do
        it 'returns all data matching the specified type' do
          bank_data = BankStatements::CSVBankData.new([], NilCategoryProcessor.new)
          bank_data.instance_variable_set(:@transactions, ALL_TYPE_DATA)
          expect(bank_data.query(nil,nil,'CHQ',nil)).to eq(DATE_2016_CHQ)
        end
      end
      describe 'multiple types are specied' do
        it 'returns all types matching any of the ones specified' do
          bank_data = BankStatements::CSVBankData.new([], NilCategoryProcessor.new)
          bank_data.instance_variable_set(:@transactions, ALL_TYPE_DATA)
          expect(bank_data.query(nil,nil,['D/D', 'CHQ'],nil)).to eq(DATE_2016_DD + DATE_2016_CHQ)
        end
      end
      describe 'date range and type' do
        it 'returns data within the range and type specified' do
          bank_data = BankStatements::CSVBankData.new([], NilCategoryProcessor.new)
          bank_data.instance_variable_set(:@transactions, ALL_TYPE_DATA)
          start_date = Date.parse('01/05/2016')
          end_date = Date.parse('31/08/2016')
          expect(bank_data.query(start_date,end_date,'POS',nil)).to eq(DATE_2016_POS_MID_YEAR)
        end
      end
    end
  end
end
