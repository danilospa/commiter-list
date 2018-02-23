require './app/interactors/commits/list'
require './app/interactors/commits/get_committers'
require './app/interactors/committers/order_by_commits_count'
require './app/interactors/committers/generate_report'

module Organizers
  module Reports
    class ExportCommittersOrderedByCommitsCount
      def initialize(interactors:)
        @interactors = interactors
      end

      def call(repository, filename, asc = true)
        commits = @interactors[:list_commits].call(repository)
        committers = @interactors[:get_committers].call(commits, include_commits_count: true)
        committers_ordered = @interactors[:order_by_commits_count].call(committers, asc)
        @interactors[:generate_report].call(committers_ordered, filename)
      end

      def self.build
        new(interactors: {
          list_commits: Interactors::Commits::List.build,
          get_committers: Interactors::Commits::GetCommitters.build,
          order_by_commits_count: Interactors::Committers::OrderByCommitsCount.build,
          generate_report: Interactors::Committers::GenerateReport.build
        })
      end
    end
  end
end
