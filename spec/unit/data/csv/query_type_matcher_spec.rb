require 'spec_helper'

describe 'CSVBankData' do
  before(:all) do
    @transaction = Transaction.new()
  end

  describe 'QueryTypeMatcher' do
    describe 'type is nil' do
      it 'matches all types' do
        type_query_matcher = BankStatements::MemoryQuery::QueryTypeMatcher.new(nil)
        @transaction.type = 'POS'
        expect(type_query_matcher.match(@transaction)).to be true
      end
    end

    describe 'single type is specified' do
      describe 'transaction contains the type' do
        it 'returns true' do
          type_query_matcher = BankStatements::MemoryQuery::QueryTypeMatcher.new('POS')
          @transaction.type = 'POS'
          expect(type_query_matcher.match(@transaction)).to be true
        end
      end
      describe 'transaction does not contain the category' do
        it 'returns false' do
          type_query_matcher = BankStatements::MemoryQuery::QueryTypeMatcher.new('POS')
          @transaction.type = 'CHQ'
          expect(type_query_matcher.match(@transaction)).to be false
        end
      end
    end

    describe 'multiple types are specified' do
      describe 'transaction contains any of the specified types' do
        it 'returns true' do
          type_query_matcher = BankStatements::MemoryQuery::QueryTypeMatcher.new(['POS', 'D/D', 'CHQ'])
          @transaction.type = 'CHQ'
          expect(type_query_matcher.match(@transaction)).to be true
        end
      end
      describe 'transaction does not contain any of the specified types' do
        it 'returns false' do
          type_query_matcher = BankStatements::MemoryQuery::QueryTypeMatcher.new(['POS', 'D/D', 'CHQ'])
          @transaction.type = 'BAC'
          expect(type_query_matcher.match(@transaction)).to be false
        end
      end
    end
  end
end
