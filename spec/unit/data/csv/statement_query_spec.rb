require 'spec_helper'
require 'data/query_category_data'
require 'data/query_date_data'
require 'data/query_type_data'

describe 'MemoryQuery' do
  describe '#query' do
    context 'transaction categories' do
      describe 'no category is specified' do
        it 'returns all data' do
          memory_query = BankStatements::MemoryQuery.new(ALL_CATEGORY_DATA)
          expect(memory_query.query(nil,nil,nil,nil)).to eq(ALL_CATEGORY_DATA)
        end
      end
      describe 'single category is specified' do
        it 'returns only data matching category' do
          memory_query = BankStatements::MemoryQuery.new(ALL_CATEGORY_DATA)
          expect(memory_query.query(nil,nil,nil,'Tesco')).to eq(DATE_2016_TESCO + DATE_2016_TESCO_PETROL)
        end
      end
      describe 'multiple categories are specified' do
        it 'returns data from specified categories' do
          memory_query = BankStatements::MemoryQuery.new(ALL_CATEGORY_DATA)
          expect(memory_query.query(nil,nil,nil,['Tesco', 'Petrol'])).to eq(DATE_2016_TESCO_PETROL)
        end
      end
      describe 'date range and type' do
        it 'returns data within the date range and category specified' do
          memory_query = BankStatements::MemoryQuery.new(ALL_CATEGORY_DATA)
          start_date = Date.parse('01/05/2016')
          end_date = Date.parse('31/08/2016')
          expect(memory_query.query(start_date,end_date,nil,'Misc')).to eq(DATE_2016_MISC_MID_YEAR)
        end
      end
    end
    context 'date ranges' do
      describe 'start and end is nil' do
        it 'returns all data' do
          memory_query = BankStatements::MemoryQuery.new(ALL_DATE_DATA)
          expect(memory_query.query(nil,nil,nil,nil)).to eq(ALL_DATE_DATA)
        end
      end
      describe 'start nil and end is specified' do
        it 'returns all data up to end date' do
          memory_query = BankStatements::MemoryQuery.new(ALL_DATE_DATA)
          end_date = Date.parse('31/12/2016')
          expect(memory_query.query(nil,end_date,nil,nil)).to eq(DATE_2015 + DATE_2016)
        end
      end
      describe 'start specified and end is nil' do
        it 'returns all data from start date' do
          memory_query = BankStatements::MemoryQuery.new(ALL_DATE_DATA)
          start_date = Date.parse('01/01/2016')
          expect(memory_query.query(start_date,nil,nil,nil)).to eq(DATE_2016 + DATE_2017)
        end
      end
      describe 'start specified and end specified' do
        it 'returns data within the range' do
          memory_query = BankStatements::MemoryQuery.new(ALL_DATE_DATA)
          start_date = Date.parse('01/01/2016')
          end_date = Date.parse('31/12/2016')
          expect(memory_query.query(start_date,end_date,nil,nil)).to eq(DATE_2016)
        end
      end
    end
    context 'transaction types' do
      describe 'no type is specified' do
        it 'returns all data' do
          memory_query = BankStatements::MemoryQuery.new(ALL_TYPE_DATA)
          expect(memory_query.query(nil,nil,nil,nil)).to eq(ALL_TYPE_DATA)
        end
      end
      describe 'single type is specified' do
        it 'returns all data matching the specified type' do
          memory_query = BankStatements::MemoryQuery.new(ALL_TYPE_DATA)
          expect(memory_query.query(nil,nil,'CHQ',nil)).to eq(DATE_2016_CHQ)
        end
      end
      describe 'multiple types are specied' do
        it 'returns all types matching any of the ones specified' do
          memory_query = BankStatements::MemoryQuery.new(ALL_TYPE_DATA)
          expect(memory_query.query(nil,nil,['D/D', 'CHQ'],nil)).to eq(DATE_2016_DD + DATE_2016_CHQ)
        end
      end
      describe 'date range and type' do
        it 'returns data within the range and type specified' do
          memory_query = BankStatements::MemoryQuery.new(ALL_TYPE_DATA)
          start_date = Date.parse('01/05/2016')
          end_date = Date.parse('31/08/2016')
          expect(memory_query.query(start_date,end_date,'POS',nil)).to eq(DATE_2016_POS_MID_YEAR)
        end
      end
    end
  end
end
