require 'spec_helper'
require 'support/nil_category_processor'
require 'data/import_data_as_structure'

describe 'HashCategoryProcessor' do
  describe 'CSV Data Load' do
    describe 'Import Multiple Test CSV files' do
      it 'loads CSV and converts into Transaction structure' do
        bank_data = BankStatements::CSVBankData.new(csv_folder: 'spec/data', category_processor: NilCategoryProcessor.new)
        expect(bank_data.transactions).to eq(IMPORT_DATA_AS_TRANSACTIONS)
      end
    end
  end

  describe '#transaction_year_span' do
    it 'queries transaction and returns an array of years' do
      bank_data = BankStatements::CSVBankData.new(csv_folder: 'spec/data')
      expect(bank_data.transaction_year_span).to eq([2015, 2016, 2017])
    end
  end
end
