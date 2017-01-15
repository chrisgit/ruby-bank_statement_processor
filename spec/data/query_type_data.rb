# Point of Sale ... to April
DATE_2016_POS_START_YEAR = [
  Transaction.new(Date.parse("01/01/2016"),"POS","POS 01/01/2016",0.0,"'Account","'12345", ['Insurance']),
  Transaction.new(Date.parse("05/02/2016"),"POS","POS 05/02/2016",0.0,"'Account","'12345", ['Supermarket'])]

# Point of Sale May to August
DATE_2016_POS_MID_YEAR = [
  Transaction.new(Date.parse("13/05/2016"),"POS","POS 13/05/2016",0.0,"'Account","'12345", ['Insurance']),
  Transaction.new(Date.parse("22/07/2016"),"POS","POS 22/07/2016",0.0,"'Account","'12345", ['Supermarket'])]

# Point of Sale September to December
DATE_2016_POS_END_YEAR = [
  Transaction.new(Date.parse("11/09/2016"),"POS","POS 11/09/2016",0.0,"'Account","'12345", ['Insurance']),
  Transaction.new(Date.parse("04/11/2016"),"POS","POS 04/11/2016",0.0,"'Account","'12345", ['Supermarket'])]

# Direct debit
DATE_2016_DD = [
  Transaction.new(Date.parse("01/02/2016"),"D/D","Direct Debit 01/02/2016",0.0,"'Account","'12345", ['Insurance']),
  Transaction.new(Date.parse("08/05/2016"),"D/D","Direct Debit 08/05/2016",0.0,"'Account","'12345", ['Supermarket']),
  Transaction.new(Date.parse("22/09/2016"),"D/D","'Direct Debit 22/09/2016",0.0,"'Account","'12345", ['Utilities'])]

# Cheque
DATE_2016_CHQ = [
  Transaction.new(Date.parse("15/03/2016"),"CHQ","Cheque 15/03/2016",0.0,"'Account","'12345", ['Gambling']),
  Transaction.new(Date.parse("19/06/2016"),"CHQ","Cheque 19/06/2016",0.0,"'Account","'12345", ['Supermarket']),
  Transaction.new(Date.parse("22/09/2016"),"CHQ","Cheque 22/09/2016",0.0,"'Account","'12345", ['Utilities'])]

ALL_TYPE_DATA = DATE_2016_POS_START_YEAR + DATE_2016_POS_MID_YEAR + DATE_2016_POS_END_YEAR + DATE_2016_DD + DATE_2016_CHQ
