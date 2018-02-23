module Interactors
  module Commits
    class GetCommitters
      def call(commits, include_commits_count: false)
        committers = commits.map do |commit|
          commit[:commit][:committer].merge({
            login: commit.dig(:committer, :login),
            avatar_url: commit.dig(:committer, :avatar_url),
          })
        end.uniq { |c| c[:email] }

        return committers unless include_commits_count

        committers.map do |committer|
          commits_count = commits_count_for_committer(committer, commits)
          committer.merge(commits_count: commits_count)
        end
      end

      def self.build
        new
      end

      private

      def commits_count_for_committer(committer, commits)
        commits.reduce(0) { |sum, c| c[:commit][:committer][:email] == committer[:email] ? sum + 1 : sum }
      end
    end
  end
end
