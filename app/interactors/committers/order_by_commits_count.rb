module Interactors
  module Committers
    class OrderByCommitsCount
      def call(committers, asc = true)
        sorted_committers = committers.sort_by { |c| c[:commits_count] }
        asc ? sorted_committers : sorted_committers.reverse
      end

      def self.build
        new
      end
    end
  end
end
