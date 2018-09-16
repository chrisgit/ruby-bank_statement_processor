module BankStatements
  class Processor

    PROCESSORS = {
      'POS' => BankStatements::HashCategoryProcessor.new(BankStatements::HashCategories::POINT_OF_SALE),
      'D/D' => BankStatements::HashCategoryProcessor.new(BankStatements::HashCategories::DIRECT_DEBIT),
      'ATM' => BankStatements::DirectMatchProcessor.new(['ATM']),
      'ATM RFD' => BankStatements::DirectMatchProcessor.new(['ATM Refund']),
      'C/L' => BankStatements::DirectMatchProcessor.new(['Cashline (Cash machine / ATM withdrawal)']),
      'CDM' => BankStatements::DirectMatchProcessor.new(['Cash Deposit Machine']),
      'CHG' => BankStatements::DirectMatchProcessor.new(['Charge']),
      'CHARGE' => BankStatements::DirectMatchProcessor.new(['Charge']),
      'CHP' => BankStatements::DirectMatchProcessor.new(['Payment by CHAPS transfer']),
      'FGN CSH FEE' => BankStatements::DirectMatchProcessor.new(['Foreign Cash Fee']),
      'FGN PUR FEE' => BankStatements::DirectMatchProcessor.new(['Foreign Purchase Fee']),
      'INT' => BankStatements::DirectMatchProcessor.new(['Interest']),
      'ITL' => BankStatements::DirectMatchProcessor.new(['International']),
      'N-S TRN FEE' => BankStatements::DirectMatchProcessor.new('Non Sterling Transaction Fee'),
      'OTR' => BankStatements::DirectMatchProcessor.new(['Interest']),
      'POC' => BankStatements::DirectMatchProcessor.new(['Post Office Counters']),
      'S/O' => BankStatements::DirectMatchProcessor.new(['Standing Order']),
      'SBT' => BankStatements::DirectMatchProcessor.new(['Screen Based Transaction'])
    }

    def self.for(type)
      PROCESSORS[type] ||= PROCESSORS['POS']
    end
  end
end

=begin
Transaction Types
ATM - Automated Teller (Cash) Machine
ATM RFD - ATM Refund
BAC - Automated Credit
BGC - Bank Giro Credit
BSP - Branch Single Payment
CDM - Cash & Deposit Machine
Charge - Previously displayed as CHG
CHP - Payment by CHAPS transfer
CHQ - Cheque
C/L - Cashline (Cash machine / ATM withdrawal)
C/R - Credit Remittance
CUI - Centralised Unpaid In (Unpaid Cheque)
CWP - Cold Weather Payment
D/D - Direct Debit
DIV - Dividend
DPC - Direct Banking by PC (payment or transfer made using online banking)
DR - Account Overdrawn or Debit Item
DWP - Department for Work and Pensions
FGN CSH FEE - Foreign Cash Fee
FGN PUR FEE - Foreign Purchase Fee
IBP - Inter-Branch Payment
INT - Interest
ITL - International
NDC - Non Dividend Counterfoil
NO WI BON - No Withdrawal Bonus
N-S TRN FEE - Non Sterling Transaction Fee
OTR - Online Banking Transaction
POC - Post Office Counters
POS - Point of Sale/Debit Card Transaction (if you don't recognise the retailer name, we might be able to help you (opens in a new window))
S/O - Standing Order
SBT - Screen Based Transaction
TEL - Telephone Banking
TFR - Transfer
TLR - Teller Transaction
VRATE - Visa Payment Scheme Exchange Rate
=end