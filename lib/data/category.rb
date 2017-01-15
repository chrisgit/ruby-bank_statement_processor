module BankStatements

  CATEGORIES =
  {
    'Supermarket' => ['Sainsbury', 'Tesco', 'Asda', 'Morrison', 'Waitrose', 
      { 'M and S' => ['Marks/Spencer', 'M and S Simply Food', 'Marks Spencer', 'Marks and Spencer', 'Sacat Marks and , Spencer'] }, 'Aldi', 'Lidl', 'Co-op'],
    'Petrol' => ['Esso', 'Shell', 'Tesco Petrol', 'BP', 'Sainsburys Petrol', 'Maple SSTN', 'Murco Petroleum', 'Falcon Garage'],
    'Utilities' => ['Co-Operative Energ', { 'British Gas' => ['British Gas', 'Brit Gas-Wales', 'Brit Gas/Elect']}, { 'Telephone' => ['BT group']} ], 
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
    'Jewellery' => ['Fitzrovia Watches', 'WF Invicta House', 'Swiss Watch', 'Goldsmiths', 'Ernest Jones', 'Beaverbrooks'],
    'Credit Card' => ['Barclaycard'],
    'Bank' => ['Natwest', 'NW AD PRIVATE CHG'],
    'Mortgage' => ['MLS P02 Woolwich'],
    'Childcare' => ['Hurst Leisure Cntr'],
    'Shares' => ['etrade'],
    'Car' => ['John Griffiths', 'Tower Garage', 'Calcot Cars', 'Whitequay', 'Headley Bodysh', 'Wheelgame', 'Charters',
      'Petersfield Motor', 'J S Autoservices', 'Advance Motor', 'Kevin Griffin', 'AA Membership', "Marshall's", 
      'City Peugeot', 'Kwik Fit', 'Foster and Heanes', 'SJB Autotech', 'Italia Speed', 'Cardrew Vehicle', 'CCS Car Sales'],
    'People' => ['Howe', 'Kelsey Oleary', 'Cheyenne Oleary', 'Tina Morris', 'Bettersee'],
    'Pets' => ['Donnington Grove', "O'Gorman Slater", 'Pampurredpets Ltd', 'Pets Corner', 'Pets at Home'],
    'Cinema' => ['Vue', 'Odeon'],
    'Interest' => ['NET 09349774'],
    'Salary' => ['NewVoiceMedia', 'NewVoice Media', 'Northgate'],
    'Charity' => ['HIOW Wildlife', 'Hampshire WLT', 'BBOWT'],
    'Insurance' => ['Legal and Gen'],
    'Gambling' => ['National Lottery'],
    'Pension' => ['Axa Sun Life'],
    'Food' => ['Blacksmiths Arms', 'The Crooked Billet', 'Welcome Break', 'Wellington Arms',
      'The Lambert Arms', 'Dexters Grill', 'Ciao Baby Cucina', 'Longbridge Mill', 'The Mill', 'Hinds Head', 'The Ben Jonson', 
      "O'Briens", 'FTB The Royal Oak', "TGI Friday's", 'Loggans Moor', 'The Swan Inn',
      'The New Standard', 'Man Yuen', 'Cinnamon Tree', 'Brambles', 'Giraffe Concepts', 'Strada', 'Brewers Fayre',
      "Stein's", 'KFC', 'The Cornwall', 'Treleigh Arms', 'Pret A Manger', 'Toby Cavery', 'Waddesdon Rest', 'Marlow Donkey', 
      'Hand and Flowers', 'Zizzi', 'Queens College', 'The Polly', 'Harvester', 'Spice Mahal', 'New Dynasty', 'McDonalds', 
      'Star Inn', 'The Queens At', 'Waterwitch', 'Swan', 'Cobblestones', 'Old Shire Inn', 'The Gate',
      { '*TableTable' => ['TableTable', 'Table , Table'] },
      { '*Dominos Pizza' => ["Domino's Pizza", 'Dominos Pizza']},
      { '*Austells' => ["Austell's", 'Austells']},
      { '*Moto' => ['Moto Retail', ' Moto ', 'Cher vly sstn moto']},
      { 'Coffee Shop' => ['Costa', 'Nero', 'Starbucks']},
      { '*Hatch' => ' Hatch '},
      'Old Bell', 'The Bull Inn', 'Nandos', 'Greggs', 'Maison Blanc', "Oldbury's Deli", 'Auntie Annes', 'Frankie and Bennys',
      'Audleys Wood', 'The White Horse', 'JD Wetherspoon', 'The New Inn', 'N G Palace', 'Cote Newbury', 'Subway', 'Le Caffe Aroma',
      'Driftwood Spars'],
    '*Transfer In' => [' FROM A/C' ],
    '*Transfer Out' => [' TO A/C' ]
  }

  class Category
    def self.category_processor
      @data ||= begin
        HashCategoryProcessor.new(CATEGORIES)
      end
    end

    def self.category_info
      @data ||= begin
        HashCategoryInfo.new(CATEGORIES)
      end
    end
  end
end