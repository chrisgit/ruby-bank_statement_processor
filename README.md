Bank Statement Processor
=========================

Simple program to load bank statements (downloaded as CSV), categorise them and enable basic search / summary details to be shown. 

## Requirements

You will need 
* Ruby installed (tested using Ruby on Windows 2.3.1)

## Installation

Download and run from source
* Set LOAD_PATH or add your program to root folder of this code
* Load the bankstatements.rb (or if program added to root folder require_relative 'lib/bankstatements') 
* Depending on your version of Ruby you may need to add bankstatements to your gem file and use bundler.

Download and build as gem
* In a command  window go to root of folder of this code
* type: gem build bank_statements.gemspec
* Install the gem
* type: gem install bank_statements-<version>.gem
* In your program type require 'bankstatements'


## Usage

#### CSVBankData

The CSVBankData class will read a CSV file, contents as below 

````
Date, Type, Description, Value, Balance, Account Name, Account Number

02/01/2009,POS,"Dummy Description",-2.00,3.50,"Current Account","123456",
````

and convert it to an internal transaction structure but ignoring the balance column.
It is assumed that the CSV file will have a header row with the fields named as the example above.
NB: the last comma on the example above is ignored but is imported as a nil field.

To open a CSV file simply pass in a reference to the file or folder in the constructor of CSVBankData

Files
````
bank_data = BankStatements::CSVBankData.new(csv_files: '/downloads/bank/statements/April2017.csv')
````

For folders you can use the static helper or create an instance of the CSVBankData class
````
# New instance
bank_data = BankStatements::CSVBankData.new(csv_folder: '/downloads/bank/statements')

# Static helper
bank_data = BankStatements::CSVBankData.from_folder('/downloads/bank/statements')
````

When the CSV file is read in it is categorised by looking at the description field and using a basic "does the description include a bit of text" logic handled with the HashCategoryProcessor.

#### HashCategoryProcessor

The HashCategoryProcessor will categorise the transactions to make it easier to find and query specific types of transaction, categorisation is based on looking for text in the description of the transaction.

The HashCategoryProcessor takes a hash / array or single value into its constructor, if hash or array is passed the HashCategoryProcessor will then descend the values looking for basic text matching the items therein.

e.g. Create a basic category hash of
````
categories = {
    'Car Costs' => ['Petrol', 'Big Garage Servicing', 'Road Tax', 'Car Insurance']
}
````

Use by passing the hash into the constructor of the CSVBankData class
````
bank_data = BankStatements::CSVBankData.new(csv_folder: '/downloads/bank/statements', category_processor: HashCategoryProcessor.new)
````

The example hash will categorise transactions that contain the words 'Petrol', 'Big Garage Servicing', 'Road Tax', 'Car Insurance' as 'Car Costs', it will also categorise the transaction with the element that matched in the description. For example a transaction that contains the description of 'Big Garage Petrol' will have the categories of 'Car Costs' and 'Petrol'.
Any transactions that do not match the text in the hash are marked as 'Misc'.

If there are several different descriptions that represent the same merchant or category then you can roll up the category so that only the top level category name is used when a match is found. Lets say for example that we want descriptions containing 'Big Garage Service Station', 'Litle Garage On Highway', 'Far Away Motorway Services' to represent Petrol, they do not have the word petrol in the description so will not match but we can still match on their descriptions and roll up to Petrol by adding an asterisk to the category key. 

e.g. Hash below will match 'Big Garage Service Station', 'Litle Garage On Highway', 'Far Away Motorway Services' but only categorise as Petrol
````
categories = {
    'Car Costs' => [{'*Petrol' => ['Big Garage Service Station', 'Litle Garage On Highway', 'Far Away Motorway Services']}, 'Big Garage Servicing', 'Road Tax', 'Car Insurance']
}
````

#### Summary Service

This class is used to summerise balance and total values

#### A simple query

````
bank_data = BankStatements::CSVBankData.from_folder('/downloads/bank/statements')
petrol = bank_data.query(nil,nil,nil,'Petrol')
petrol.count # number of transactions
petrol.map {|p| p.value }.inject(:+) # Total cost of Petrol

# Transactions between £20 and £60
require 'pp'
cc = bank_data.transactions.select {|t| t.value < -20 && t.value > -60 }
pp cc.map {|t| {'d': t.description, 'c': t.categories } }
````

#### Ruby versions

Works with Ruby versions
* 2.3.1p112 (2016-04-26 revision 54768) [i386-mingw32]

