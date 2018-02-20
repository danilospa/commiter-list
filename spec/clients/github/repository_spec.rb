require './app/clients/github/repository'

RSpec.describe Clients::Github::Repository do
  before do
    stub_const('Clients::Github::BASE_URL', gh_base_url)
  end

  let(:gh_base_url) { 'gh_base_url' }
  let(:repo_name) { 'repo_name' }

  let(:http_client) do
    klass = double('Net::HTTP')
    allow(klass).to receive(:get_response).and_return(http_response)
    klass
  end
  let(:http_response) do
    klass = double('Net::HTTP::Response')
    allow(klass).to receive(:body).and_return([].to_json)
    klass
  end

  subject { described_class.new(repository_name: repo_name, http_client: http_client) }

  describe '#commits' do
    context 'when fetching a single page' do
      it 'gets commits using correct url when no page is given' do
        expect(http_client).to receive(:get_response).with(URI("#{gh_base_url}/repos/#{repo_name}/commits?page=0"))
        subject.commits
      end

      it 'gets commits using correct url when an page is given' do
        expect(http_client).to receive(:get_response).with(URI("#{gh_base_url}/repos/#{repo_name}/commits?page=2"))
        subject.commits(page: 2)
      end

      it 'returns first response body symbolized' do
        allow(http_response).to receive(:body).and_return({ data: 'value' }.to_json)
        expect(subject.commits).to eq data: 'value'
      end
    end

    context 'when fetching all commits' do
      before do
        first_mocked_header = {
          'link' => ['<github_url?page=1>; rel="next"']
        }
        second_mocked_header = {
          'link' => ['']
        }
        allow(http_response).to receive(:to_hash).and_return(first_mocked_header, second_mocked_header)
      end

      it 'requests next page' do
        expect(http_client).to receive(:get_response).with(URI("#{gh_base_url}/repos/#{repo_name}/commits?page=0"))
        expect(http_client).to receive(:get_response).with(URI("#{gh_base_url}/repos/#{repo_name}/commits?page=1"))
        subject.commits(fetch_all: true)
      end

      it 'returns responses appended' do
        first_response = [1].to_json
        second_response = [2].to_json
        allow(http_response).to receive(:body).and_return(first_response, second_response)
        expect(subject.commits(fetch_all: true)).to eq [1, 2]
      end
    end
  end
end
