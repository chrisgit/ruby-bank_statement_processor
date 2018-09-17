require_relative '../../refinements/string'
using StringRefinements

module BankStatements
  module HashCategories

    CATEGORIES =
    {
      'Supermarket' => [
        'Sainsbury', 'Tesco', 'Asda', 'Morrison', 'Waitrose', 'Aldi', 'Lidl', 
        'M and S'.when_matches_with('Marks/Spencer', 'M and S Simply Food', 'Marks Spencer', 'Marks and Spencer', 'Sacat Marks and , Spencer'),
        'Co-op'.when_matches_with('Co-op,')
      ],
      'Petrol' => [
        'Esso', 'Shell', 'Tesco Petrol', 'Tesco Pay at Pump', 'BP', 'Sainsburys Petrol', 'Maple SSTN', 'Murco Petroleum', 'Falcon Garage'
      ],
      'Bills' => [
        'Utilities' => [
          'Co-op'.when_matches_with('Co-Operative Energ'), 
          'British Gas'.when_matches_with('British Gas', 'Brit Gas-Wales', 'Brit Gas/Elect'), 
          { 'Telephone' => ['BT group'] }
        ],
        'Water' => ['Southern Water', 'Thames Water'],
        'Mobile' => ['O2', 'Tesco mobile', 'Carphone Warehouse', 'Nokia', 'Vodafone'],
        'Council' => ['Basingstoke and Dean'],
        'Sky' => ['Sky Digital'],
        'Car Tax' => ['DVLA']
      ],
      'High Street' => [
        'Halfords', 'Primark', 'Kings DIY', 'WH Smith', 'Holland and Barrett',
        'QubeFootwear', 'Superdrug', 'B and Q', 'Matalan', 'Borders', 'Staples', 'Boots',
        'PC World'.when_matches_with('DSG Retail'), 'HMV', 'Homebase', 'Camp Hopson',
        'Wyevale', 'Game Stores', 'Wickes', 'Novatech', 'Thorntons', 'Tula Factory', 
        'Reading Warehouse', 'Madhouse', 'Richer Sounds', 'Sound Gallery', 
        'Thorntons', 'Maplin', 'Post Office', 'PostOffice', 'Interflora', 'Argos', 'Hawkins Bazaar', 
        'Blockbuster', 'The Garden Centre', 'John Lewis', 'Clinton Cards', 'SportsDirect', 'Waterstones',
        'Timberland', 'Robert Dyas', 'Jones Bootmaker', 'Makro', 'Birthdays', 'Wilkinson', 'Currys', 'House of Fraser',
        'Comet', 'Debenhams', 'Poundstretcher', 'Lakeside Garden', 'Festival Garden', 'Best Buy',
        'The Works', 'Beatties', 'Costco', 'Winklebury Cycles', 'Home Bargains', 'Wilson Electrical',
        'Clintons', 'Three Store', 'B and M retail', 'Julian Graves', 'Screwfix', 'Majestic Wine', 
        'The Body Shop', 'Poundland', 'Ecco Shoes', 'The Range', 'Amazon',
        'Precious Thymes','99p Stores','Wilko Retail Limit', 'Ikea', 'Snappy Snaps',
        'HomeSense', 'Booksplus', 'IStore',
        'TK Maxx'.when_matches_with('T K Maxx', 'TK Maxx'), 'Leightons', 'Game Retail Ltd'
      ]
    }
  end
end
