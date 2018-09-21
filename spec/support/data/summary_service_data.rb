# Payments in  ... total 393.11
PAYMENTS_IN_2016 = [
  Transaction.new(Date.parse("01/01/2016"),"BAC","BACS 01/01/2016",168.13,"'Account","'12345", ['Paid In']),
  Transaction.new(Date.parse("05/02/2016"),"BAC","BACS 05/02/2016",224.98,"'Account","'12345", ['Paid In'])]

# Payments out ... total 318.51
PAYMENTS_OUT_2016 = [
  Transaction.new(Date.parse("13/05/2016"),"POS","POS 13/05/2016",-123.95,"'Account","'12345", ['Insurance']),
  Transaction.new(Date.parse("22/07/2016"),"POS","POS 22/07/2016",-194.56,"'Account","'12345", ['Supermarket'])]

# Payments in ... total 596.13
PAYMENTS_IN_2017 = [
  Transaction.new(Date.parse("11/09/2017"),"BAC","POS 11/09/2016",337.14,"'Account","'12345", ['Paid In']),
  Transaction.new(Date.parse("04/11/2017"),"POS","POS 04/11/2016",258.99,"'Account","'12345", ['Paid In'])]

# Payments out ... 356.46
PAYMENTS_OUT_2017 = [
  Transaction.new(Date.parse("01/02/2016"),"POS","POS 01/02/2016",-210.25,"'Account","'12345", ['Insurance']),
  Transaction.new(Date.parse("08/05/2016"),"POS","POS 08/05/2016",-66.84,"'Account","'12345", ['Supermarket']),
  Transaction.new(Date.parse("22/09/2016"),"POS","POS 22/09/2016",-79.37,"'Account","'12345", ['Utilities'])]

# Total In     989.24
# Total out    674.97
# Balance      214.27

ALL_SUMMARY_DATA = PAYMENTS_IN_2016 + PAYMENTS_OUT_2016 + PAYMENTS_IN_2017 + PAYMENTS_OUT_2017
