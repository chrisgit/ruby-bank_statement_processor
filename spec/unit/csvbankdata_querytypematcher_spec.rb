require 'spec_helper'

describe 'CSVBankData' do
  describe 'QueryTypeMatcher' do
    describe 'type is nil' do
      it 'matches all types' do
        type_query_matcher = BankStatements::CSVBankData::QueryTypeMatcher.new(nil)
        transaction = double()
        allow(transaction).to receive(:type).and_return('POS')
        expect(type_query_matcher.match(transaction)).to be true
      end
    end

    describe 'single type is specified' do
      describe 'transaction contains the type' do
        it 'returns true' do
          type_query_matcher = BankStatements::CSVBankData::QueryTypeMatcher.new('POS')
          transaction = double()
          allow(transaction).to receive(:type).and_return('POS')
          expect(type_query_matcher.match(transaction)).to be true
        end
      end
      describe 'transaction does not contain the category' do
        it 'returns false' do
          type_query_matcher = BankStatements::CSVBankData::QueryTypeMatcher.new('POS')
          transaction = double()
          allow(transaction).to receive(:type).and_return('CHQ')
          expect(type_query_matcher.match(transaction)).to be false
        end
      end
    end

    describe 'multiple types are specified' do
      describe 'transaction contains any of the specified types' do
        it 'returns true' do
          type_query_matcher = BankStatements::CSVBankData::QueryTypeMatcher.new(['POS', 'D/D', 'CHQ'])
          transaction = double()
          allow(transaction).to receive(:type).and_return('CHQ')
          expect(type_query_matcher.match(transaction)).to be true
        end
      end
      describe 'transaction does not contain any of the specified types' do
        it 'returns false' do
          type_query_matcher = BankStatements::CSVBankData::QueryTypeMatcher.new(['POS', 'D/D', 'CHQ'])
          transaction = double()
          allow(transaction).to receive(:type).and_return('BAC')
          expect(type_query_matcher.match(transaction)).to be false
        end
      end
    end
  end
end
