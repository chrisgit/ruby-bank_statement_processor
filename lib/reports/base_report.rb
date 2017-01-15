# Base class for reports
module BankStatements
  module Reports
    class BaseReport

      private

      def report_line(text)
        puts text
      end

      def heading(heading_text)
        report_line('=' * heading_text.length)
        report_line(heading_text)
        report_line('=' * heading_text.length)
      end

      def blank_line
        report_line('')
      end
    end
  end
end
