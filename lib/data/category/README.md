Processing Transaction Categories
---------------------------------

The Bank Statements as supplied via download contain the following information

The Bank transaction types are 
- POS (Point of Sale)
- D/D (Direct Debit)

What I wanted to do was to categorise transactions not by transaction type but by type of spending, i.e.
- Food shopping
- Petrol
- Insurance

Unfortunately the only way to determine what the transaction relates to is to read the description; therein lies a bigger problem, the description for the same type of transaction can vary, for example TESCO PETROL can be 
- TESCO PAY AT PUMP
- TESCO PETROL

Therefore to determine the spend type we need a description processor or parser! The parser can then help categorise the transaction into the spend type.

Background
----------

When this program was originally written as a C# program, the category processor was a type of 'plugin' using a combination of command and chain of responsibility pattern. Each category rule a distinct object, similar to below

````
class Sainsburys
  bool IsHandled = false;

  public string Execute(string description)
  {
     if (description.Contains("SAINSBURY"))
    {
        category = 'Supermarket, High Street, Sainsburys';
        IsHandled = true;
    }

    return category;
  }
end
````

This method is accurate but laborious as it requires a lot of classes / coding and conditions to handle variations.

When this project was re-written in Ruby (just for fun) I wanted to make a generic processor that could handle *most* situations, enter the hash category processor.

Hash Category Processor
-----------------------

The hash category processor accepts a Ruby hash as an argument, the keys of the hash are the categories and the values are strings to match against the description, for example

````
{
  'Tesco' => 'Tesco Stores Plc'
}
```` 

If the description contains 'Tesco Stores Plc' (case ignored) then the transaction category will be marked 'Tesco' and 'Tesco Stores Plc'.

The rules processing is a little more sophisticated though, several descriptions can be categorised in the same way, to do this the hash value has to be an array of items

````
'Supermarket' => ['Sainsbury', 'Tesco', 'Asda', 'Morrison', 'Waitrose']
````

If any of the descriptions contain 'Sainsbury', 'Tesco', 'Asda', 'Morrison', 'Waitrose' then the category will be 'Supermarket' plus whatever match, say for example the description contained 'Asda' the category will actually be 'Supermarket' and 'Asda'.

Sometimes the description may vary for the same supplier, Marks and Spencer sometimes output any of these descriptions
- Marks/Spencer
- M and S Simply Food
- Marks Spencer
- Marks and Spencer

When analysing spend it would be awkward to query all category occurances for Marks and Spencer, the hash processor can translate the variants in the description and map them to a single value, for example

````
 { 'M and S' => ['Marks/Spencer', 'M and S Simply Food', 'Marks Spencer', 'Marks and Spencer', 'Sacat Marks and , Spencer'] }
````

If the description matches  'Marks/Spencer', 'M and S Simply Food', 'Marks Spencer', 'Marks and Spencer', 'Sacat Marks and , Spencer', if the description contains 'M and S Simply Food' the category will be 'M and S' and 'M and S Simply Food', not much different from the last example but the hashes can be embedded, for example

````
'Supermarket' => ['Sainsbury', 'Tesco', 'Asda', 'Morrison', 'Waitrose', 
  { 'M and S' => ['Marks/Spencer', 'M and S Simply Food', 'Marks Spencer', 'Marks and Spencer', 'Sacat Marks and , Spencer'] }, 'Aldi', 'Lidl', 'Co-op']
````

Now a description containing 'M and S Simply Food' will be categorised as 'Supermarket', 'M and S', 'M and S Simply Food'.

The hash processor can match text in the description but categorise it as something else, it does this by marking the hash key with an asterisk, for example Dominos Pizza can have the description text of 
- Domino's Pizza
- Dominos Pizza

In either case we want to categorise this as 'Dominos Pizza', to do that we create a hash with a key starting with an asterisk

````
{ '*Dominos Pizza' => ["Domino's Pizza", 'Dominos Pizza']}
````

Both versions of Dominos Pizza (with and without apostrophe) will be categorised as Dominos Pizza.

The Hash Category processor is cumulative, that is a transaction can be marked as 'Supermarket', 'Tesco', 'Petrol' or 'Petrol', 'Esso', 'Maple SSTN', thereby making some summary or total reports appear incorrect as 'Tesco' will include ALL references to Tesco.

The older C# program was specific about the transaction category but as mentioned earlier was more code and logic.
