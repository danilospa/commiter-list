require './app/config'
require_relative './github/repository'

module Clients
  module Github
    BASE_URL = Config::GITHUB_BASE_URL
  end
end
