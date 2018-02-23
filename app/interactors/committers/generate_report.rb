require './app/reports/committers'

module Interactors
  module Committers
    class GenerateReport
      def initialize(report:)
        @report = report
      end

      def call(committers, filename)
        @report.new(committers).generate(filename)
      end

      def self.build
        new(report: Reports::Committers)
      end
    end
  end
end
