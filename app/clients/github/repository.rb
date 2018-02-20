require 'net/http'
require 'json'

module Clients
  module Github
    class Repository
      def initialize(repository_name:, http_client:)
        @repository_name = repository_name
        @http_client = http_client
      end

      def commits(page: 0, fetch_all: false)
        uri = URI("#{Github::BASE_URL}/repos/#{@repository_name}/commits?page=#{page}")
        response = @http_client.get_response(uri)
        response_body = JSON.parse(response.body, symbolize_names: true)
        return response_body unless fetch_all

        next_page = extract_next_page(response)
        response_body.concat(next_page ? commits(page: next_page, fetch_all: true): [])
      end

      def self.build(repository)
        new(repository_name: repository, http_client: Net::HTTP)
      end

      private

      def extract_next_page(response)
        link_header = response.to_hash['link'].first
        match = /<.*page=(.*)>; rel=\"next\"/.match(link_header)
        return match[1] if match
      end
    end
  end
end
