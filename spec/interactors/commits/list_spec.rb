require './app/interactors/commits/list'

RSpec.describe Interactors::Commits::List do
  let(:repo_name) { 'repo_name' }

  let(:repository_client) do
    klass = double('RepositoryClient')
    allow(klass).to receive(:build).and_return(klass)
    allow(klass).to receive(:commits)
    klass
  end

  subject { described_class.new(repository_client: repository_client).call(repo_name) }

  describe '#call' do
    it 'builds client from correct repository' do
      expect(repository_client).to receive(:build).with(repo_name)
      subject
    end

    it 'fetchs all commits' do
      expect(repository_client).to receive(:commits).with(fetch_all: true)
      subject
    end

    it 'returns contributors from repository client' do
      allow(repository_client).to receive(:commits).and_return('commits')
      expect(subject).to eq 'commits'
    end
  end
end

