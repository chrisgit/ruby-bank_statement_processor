require 'spec_helper'

describe 'CSVBankData' do
  describe 'QueryCategoryMatcher' do
    describe 'category is nil' do
      it 'matches all categories' do
        category_query_matcher = BankStatements::CSVBankData::QueryCategoryMatcher.new(nil)
        transaction = double()
        allow(transaction).to receive(:categories).and_return(['Misc'])
        expect(category_query_matcher.match(transaction)).to be true
      end
    end

    describe 'single category is specified' do
      describe 'transaction contains the category' do
        it 'returns true' do
          category_query_matcher = BankStatements::CSVBankData::QueryCategoryMatcher.new('Tesco')
          transaction = double()
          allow(transaction).to receive(:categories).and_return(['Supermaket', 'Tesco', 'Petrol'])
          expect(category_query_matcher.match(transaction)).to be true
        end
      end
      describe 'transaction does not contain the category' do
        it 'returns false' do
          category_query_matcher = BankStatements::CSVBankData::QueryCategoryMatcher.new('Tesco')
          transaction = double()
          allow(transaction).to receive(:categories).and_return(['Supermaket', 'Sainsbury', 'Petrol'])
          expect(category_query_matcher.match(transaction)).to be false
        end
      end
    end

    describe 'multiple categories are specified' do
      describe 'transaction contains all of the specified categories' do
        it 'returns true' do
          category_query_matcher = BankStatements::CSVBankData::QueryCategoryMatcher.new(['Tesco', 'Petrol'])
          transaction = double()
          allow(transaction).to receive(:categories).and_return(['Supermaket', 'Tesco', 'Petrol'])
          expect(category_query_matcher.match(transaction)).to be true
        end
      end
      describe 'transaction does not contain all of the specified category' do
        it 'returns false' do
          category_query_matcher = BankStatements::CSVBankData::QueryCategoryMatcher.new(['Tesco', 'Petrol'])
          transaction = double()
          allow(transaction).to receive(:categories).and_return(['Supermaket', 'Tesco', 'Clothes'])
          expect(category_query_matcher.match(transaction)).to be false
        end
      end
    end
  end
end
