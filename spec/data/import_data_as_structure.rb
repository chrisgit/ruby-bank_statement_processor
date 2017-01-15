TRANSACTIONS_2015 = [
  Transaction.new(Date.parse("01/01/2015"),"POS","'3566 01JAN15 0000 , WH SMITHS",-6.56,"'Account","'12345", ""),
  Transaction.new(Date.parse("14/08/2015"),"POS","'3566 14AUG15 0913 , HIGH STREET JEWELLER",-16.88,"'Account","'12345", ""),
  Transaction.new(Date.parse("24/12/2015"),"D/D","'WATER AND SEWAGE COMPANY",-95.00,"'Account","'12345", "")]

TRANSACTIONS_2016 = [
  Transaction.new(Date.parse("15/03/2016"),"POS","'3566 15MARCH16 0000 , NATIONAL LOTTERY , INTERACTIVE",-79.50,"'Account","'12345", ""),
  Transaction.new(Date.parse("19/06/2016"),"POS","'3566 19JUNE16 0913 , SAINSBURYS SUPMKTS, TADLEY",-16.88,"'Account","'12345", ""),
  Transaction.new(Date.parse("22/09/2016"),"D/D","'BT GROUP PLC",-19.50,"'Account","'12345", "")]

TRANSACTIONS_2017 = [
  Transaction.new(Date.parse("20/02/2017"),"POS","'PREMIUM HOME INSURANCE",-655.00,"'Account","'12345", ""),
  Transaction.new(Date.parse("08/05/2017"),"POS","'3566 08MAY2017 , TESCO STORES",-1128.63,"'Account","'12345", ""),
  Transaction.new(Date.parse("22/09/2017"),"D/D","'BRITISH GAS",-158.90,"'Account","'12345", "")]


IMPORT_DATA_AS_TRANSACTIONS = TRANSACTIONS_2015 + TRANSACTIONS_2016 + TRANSACTIONS_2017
