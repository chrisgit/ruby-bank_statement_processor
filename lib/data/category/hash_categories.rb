module BankStatements
  module HashCategories

    CATEGORIES =
    {
      'Supermarket' => ['Sainsbury', 'Tesco', 'Asda', 'Morrison', 'Waitrose', 
        { 'M and S' => ['Marks/Spencer', 'M and S Simply Food', 'Marks Spencer', 'Marks and Spencer', 'Sacat Marks and , Spencer'] }, 'Aldi', 'Lidl', 
        {'*Co-op' => ['Co-op,']}],
      'Petrol' => ['Esso', 'Shell', 'Tesco Petrol', 'Tesco Pay at Pump', 'BP', 'Sainsburys Petrol', 'Maple SSTN', 'Murco Petroleum', 'Falcon Garage'],
      'Utilities' => [{ '*Co-op' => ['Co-Operative Energ']}, { 'British Gas' => ['British Gas', 'Brit Gas-Wales', 'Brit Gas/Elect']}, { 'Telephone' => ['BT group']} ], 
      'Water' => ['Southern Water', 'Thames Water'],
      'Mobile' => ['O2', 'Tesco mobile', 'Carphone Warehouse', 'Nokia', 'Vodafone'],
      'Council' => ['Basingstoke and Dean'],
      'Sky' => ['Sky Digital'],
      'High Street' => ['Halfords', 'Primark', 'Kings DIY', 'WH Smith', 'Holland and Barrett', 'QubeFootwear',
        'Superdrug', 'B and Q', 'Matalan', 'Borders', 'Staples', 'Boots', 'PC World', 'HMV', 'Homebase', 'Camp Hopson',
        'Wyevale', 'Game Stores', 'Wickes', 'Novatech', 'Thorntons', 'Tula Factory', 'Reading Warehouse', 'Madhouse',
        'Richer Sounds', 'Sound Gallery', 'Thorntons', 'Maplin', 'Post Office', 'PostOffice', 'Interflora', 'Argos',
        'Hawkins Bazaar', 'Blockbuster', 'The Garden Centre', 'John Lewis', 'Clinton Cards', 'SportsDirect', 'Waterstones',
        'Timberland', 'Robert Dyas', 'Jones Bootmaker', 'Makro', 'Birthdays', 'Wilkinson', 'Currys', 'House of Fraser',
        'Comet', 'Debenhams', 'Poundstretcher', 'Lakeside Garden', 'Festival Garden', 'Best Buy',
        'The Works', 'Beatties', 'Costco', 'Winklebury Cycles', 'Home Bargains', 'Wilson Electrical',
        'Clintons', 'Three Store', 'B and M retail', 'Julian Graves', 'Screwfix', 'Majestic Wine', 
        'The Body Shop', 'Poundland', 'Ecco Shoes', 'The Range', 'Amazon',
        'Precious Thymes','99p Stores','Wilko Retail Limit',
        {'TK Maxx' => ['T K Maxx', 'TK Maxx']}],
      'Credit Card' => ['Barclaycard', 'TESCO CREDIT CARDS'],
      'Bank' => ['Natwest', 'NW AD PRIVATE CHG'],
      'Car Tax' => ['DVLA'],
      'Cinema' => ['Vue', 'Odeon'],
      'Gambling' => ['National Lottery'],
      '*Transfer In' => [' FROM A/C' ],
      '*Transfer Out' => [' TO A/C' ]
    }
  end
end
