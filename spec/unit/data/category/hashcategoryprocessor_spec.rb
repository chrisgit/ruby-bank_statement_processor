require 'spec_helper'
require 'support/test_categories'

describe 'HashCategoryProcessor' do
  let(:category_processor) { BankStatements::HashCategoryProcessor.new(TEST_CATEGORIES) }

  describe '#process_category' do
    describe 'description contains [Tesco] [Petrol]' do
      it 'category is [Tesco] [Petrol]' do
        categories = category_processor.process_category('TESCO PETROL 4156 , READING')
        expect(categories).to include('Tesco')
        expect(categories).to include('Petrol')
      end
    end

    describe 'category consolidation - include sub categories' do
      # Category roll up, show all matches categories
      describe 'description contains [Co-operative]' do
        it 'category is [Co-op] [Co-operative]' do
          categories = category_processor.process_category('Co-operative Stores, Tadley')
          expect(categories).to include('Co-op')
          expect(categories).to include('Co-operative')
        end
      end
    end

    describe 'category consolidation - prefix asterix, only use top level category' do
      # Category roll up
      describe 'description contains [Sacat Marks and , Spencer]' do
        it 'category is [M and S]' do
          categories = category_processor.process_category('SACAT MARKS AND , SPENCER , BASINGSTOKE GB')
          expect(categories).to include('M and S')
        end
      end

      # Second Example ... double roll up
      describe 'description contains [Super Dry]' do
        it 'category is [Clothes]' do
          categories = category_processor.process_category('SUPER DRY STORES, BASINGSTOKE')
          expect(categories).to include('Clothes')
          expect(categories).to_not include('SuperDry')
        end
      end
    end

    describe 'no category match' do
      # Default to MISC if no category matches
      describe 'description contains [UNMATCHED]' do
        it 'category is [Misc]' do
          categories = category_processor.process_category('UNMATCHED PAYMENT TO A/C 123456')
          expect(categories).to include('Misc')
        end
      end

    end
  end
end
