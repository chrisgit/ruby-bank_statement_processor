require 'csv'
require_relative 'csv_ext'

module BankStatements
  class CSVStatementReader

    def initialize(statement_folder)
      @statement_files = resolve_folder(statement_folder)
    end

    def read(&block)
      # If block given then execute for each row
      transactions = []
      @statement_files.each do |filename|
        CSV.read(filename, headers: true, skip_blanks: true, header_converters: [:trim_header, :symbol], :converters => :all).each do |row|
          row = yield(row) if block_given?
          transactions << row
        end
      end
      transactions
    end

    private

    def resolve_folder(statement_folder)
      statement_folder.gsub!('\\', '/')
      Dir["#{statement_folder}/*.csv"].map(&File.method(:realpath))
    end
  end
end
