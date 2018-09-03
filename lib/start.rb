require_relative 'bankstatements'
require_relative 'service_register'
# Repositories.rb ... default folder to root/statements
Repository.register(:statements, BankStatements::CSVStatementRepository.new(File.expand_path('../statements', __dir__)))
Repository.register(:categories, BankStatements::CategoryRepository.new)

# Service
Service.register(:balance, BankStatements::BalanceService.new(Repository.for(:statements)))
Service.register(:category_totals, BankStatements::CategoryTotalsService.new(Repository.for(:statements), Repository.for(:categories)))
Service.register(:monthly_spend, BankStatements::MonthlySpendService.new(Repository.for(:statements)))

# Reports
Report.register(:category_by_year, BankStatements::Reports::SummaryByCategoryByYear.new(Service.for(:category_totals)))
Report.register(:monthly_spend, BankStatements::Reports::MonthlySpend.new(Repository.for(:statements)))
Report.register(:monthly_balance, BankStatements::Reports::MonthlyBalance.new(Repository.for(:statements)))
Report.register(:unmapped, BankStatements::Reports::MiscellaneousItems.new(Repository.for(:statements)))
