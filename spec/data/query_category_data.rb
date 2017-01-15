# MISC ... to April
DATE_2016_MISC_START_YEAR = [
  Transaction.new(Date.parse("01/01/2016"),"POS","Misc 01/01/2016",0.0,"'Account","'12345", ['Misc']),
  Transaction.new(Date.parse("05/02/2016"),"POS","Misc 05/02/2016",0.0,"'Account","'12345", ['Misc'])]

# MISC May to August
DATE_2016_MISC_MID_YEAR = [
  Transaction.new(Date.parse("13/05/2016"),"POS","Misc 13/05/2016",0.0,"'Account","'12345", ['Misc']),
  Transaction.new(Date.parse("22/07/2016"),"POS","Misc 22/07/2016",0.0,"'Account","'12345", ['Misc'])]

# MISC September to December
DATE_2016_MISC_END_YEAR = [
  Transaction.new(Date.parse("11/09/2016"),"POS","Misc 11/09/2016",0.0,"'Account","'12345", ['Misc']),
  Transaction.new(Date.parse("04/11/2016"),"POS","Misc 04/11/2016",0.0,"'Account","'12345", ['Misc'])]

# Tesco
DATE_2016_TESCO = [
  Transaction.new(Date.parse("01/02/2016"),"POS","Tesco 01/02/2016",0.0,"'Account","'12345", ['Tesco']),
  Transaction.new(Date.parse("08/05/2016"),"POS","Tesco 08/05/2016",0.0,"'Account","'12345", ['Tesco'])]

# Tesco Petrol
DATE_2016_TESCO_PETROL = [
  Transaction.new(Date.parse("01/02/2016"),"POS","Tesco 01/02/2016",0.0,"'Account","'12345", ['Tesco', 'Petrol'])]

# Petrol
DATE_2016_PETROL = [
  Transaction.new(Date.parse("15/03/2016"),"POS","Petrol 15/03/2016",0.0,"'Account","'12345", ['Petrol']),
  Transaction.new(Date.parse("19/06/2016"),"POS","Petrol 19/06/2016",0.0,"'Account","'12345", ['Petrol']),
  Transaction.new(Date.parse("22/09/2016"),"POS","Petrol 22/09/2016",0.0,"'Account","'12345", ['Petrol'])]

ALL_CATEGORY_DATA = DATE_2016_MISC_START_YEAR + DATE_2016_MISC_MID_YEAR + DATE_2016_MISC_END_YEAR + DATE_2016_TESCO + DATE_2016_TESCO_PETROL + DATE_2016_PETROL
