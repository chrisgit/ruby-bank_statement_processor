require 'spec_helper'
require 'support/nil_category_processor'
require 'data/query_date_data'

describe 'CSVBankData' do
  describe '#query' do
    describe 'date ranges' do
      describe 'start and end is nil' do
        it 'returns all data' do
          bank_data = BankStatements::CSVBankData.new([], NilCategoryProcessor.new)
          bank_data.instance_variable_set(:@transactions, ALL_DATE_DATA)
          expect(bank_data.query(nil,nil,nil,nil)).to eq(ALL_DATE_DATA)
        end
      end
      describe 'start nil and end is specified' do
        it 'returns all data up to end date' do
          bank_data = BankStatements::CSVBankData.new([], NilCategoryProcessor.new)
          bank_data.instance_variable_set(:@transactions, ALL_DATE_DATA)
          end_date = Date.parse('31/12/2016')
          expect(bank_data.query(nil,end_date,nil,nil)).to eq(DATE_2015 + DATE_2016)
        end
      end
      describe 'start specified and end is nil' do
        it 'returns all data from start date' do
          bank_data = BankStatements::CSVBankData.new([], NilCategoryProcessor.new)
          bank_data.instance_variable_set(:@transactions, ALL_DATE_DATA)
          start_date = Date.parse('01/01/2016')
          expect(bank_data.query(start_date,nil,nil,nil)).to eq(DATE_2016 + DATE_2017)
        end
      end
      describe 'start specified and end specified' do
        it 'returns data within the range' do
          bank_data = BankStatements::CSVBankData.new([], NilCategoryProcessor.new)
          bank_data.instance_variable_set(:@transactions, ALL_DATE_DATA)
          start_date = Date.parse('01/01/2016')
          end_date = Date.parse('31/12/2016')
          expect(bank_data.query(start_date,end_date,nil,nil)).to eq(DATE_2016)
        end
      end
    end
  end
end
