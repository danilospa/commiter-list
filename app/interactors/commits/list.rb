require './app/clients/github'

module Interactors
  module Commits
    class List
      def initialize(repository_client:)
        @repository_client = repository_client
      end

      def call(repository)
        @repository_client.build(repository).commits(fetch_all: true)
      end

      def self.build
        new(repository_client: Clients::Github::Repository)
      end
    end
  end
end
