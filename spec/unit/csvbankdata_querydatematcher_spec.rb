require 'spec_helper'

describe 'CSVBankData' do
  describe 'QueryDateMatcher' do
    describe 'start and end dates are nil' do
      it 'permits all dates' do
        date_query_matcher = BankStatements::CSVBankData::QueryDateMatcher.new(nil,nil)
        transaction = double()
        allow(transaction).to receive(:date).and_return(Date.parse('21/03/2017'))
        expect(date_query_matcher.match(transaction)).to be true
      end
    end

    describe 'start date specified and end date is nil' do
      describe 'date is before start date' do
        it 'returns false' do
          date_query_matcher = BankStatements::CSVBankData::QueryDateMatcher.new(Date.parse('01/04/2017'),nil)
          transaction = double()
          allow(transaction).to receive(:date).and_return(Date.parse('21/03/2017'))
          expect(date_query_matcher.match(transaction)).to be false
        end
      end
      describe 'date is after start date' do
        it 'returns true' do
          date_query_matcher = BankStatements::CSVBankData::QueryDateMatcher.new(Date.parse('01/04/2017'),nil)
          transaction = double()
          allow(transaction).to receive(:date).and_return(Date.parse('02/04/2017'))
          expect(date_query_matcher.match(transaction)).to be true
        end
      end
    end

    describe 'start date is nil and end date is specified' do
      describe 'date is before end date' do
        it 'returns true' do
          date_query_matcher = BankStatements::CSVBankData::QueryDateMatcher.new(nil, Date.parse('01/04/2017'))
          transaction = double()
          allow(transaction).to receive(:date).and_return(Date.parse('21/03/2017'))
          expect(date_query_matcher.match(transaction)).to be true
        end
      end
      describe 'date is after end date' do
        it 'returns false' do
          date_query_matcher = BankStatements::CSVBankData::QueryDateMatcher.new(nil, Date.parse('01/04/2017'))
          transaction = double()
          allow(transaction).to receive(:date).and_return(Date.parse('02/04/2017'))
          expect(date_query_matcher.match(transaction)).to be false
        end
      end
    end

    describe 'start and end dates are specified' do
      describe 'date is before start date' do
        it 'returns false' do
          date_query_matcher = BankStatements::CSVBankData::QueryDateMatcher.new(Date.parse('01/03/2017'), Date.parse('30/04/2017'))
          transaction = double()
          allow(transaction).to receive(:date).and_return(Date.parse('25/02/2017'))
          expect(date_query_matcher.match(transaction)).to be false
        end
      end
      describe 'date is after end date' do
        it 'returns false' do
          date_query_matcher = BankStatements::CSVBankData::QueryDateMatcher.new(Date.parse('01/03/2017'), Date.parse('30/04/2017'))
          transaction = double()
          allow(transaction).to receive(:date).and_return(Date.parse('01/05/2017'))
          expect(date_query_matcher.match(transaction)).to be false
        end
      end
      describe 'date is between start and end date' do
        it 'returns true' do
          date_query_matcher = BankStatements::CSVBankData::QueryDateMatcher.new(Date.parse('01/03/2017'), Date.parse('30/04/2017'))
          transaction = double()
          allow(transaction).to receive(:date).and_return(Date.parse('02/04/2017'))
          expect(date_query_matcher.match(transaction)).to be true
        end
      end
    end
  end
end
