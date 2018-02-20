require './app/clients/github'

RSpec.describe Clients::Github do
  it 'sets correct base url based on config' do
    expect(described_class::BASE_URL).to eq Config::GITHUB_BASE_URL
  end
end
