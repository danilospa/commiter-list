require './app/organizers/reports/export_committers_ordered_by_commits_count'

def mock_interactor(name)
  klass = double(name)
  allow(klass).to receive(:call)
  klass
end

RSpec.describe Organizers::Reports::ExportCommittersOrderedByCommitsCount do
  let(:list_commits_interactor) { mock_interactor('ListCommits') }
  let(:get_committers_interactor) { mock_interactor('GetCommitters') }
  let(:order_by_commits_count_interactor) { mock_interactor('OrderByCommitsCount') }
  let(:generate_report_interactor) { mock_interactor('GenerateReport') }

  let(:repo_name) { 'repo_name' }
  let(:file_name) { 'file_name' }
  let(:asc_order) { 'asc_order' }

  subject do
    described_class.new(interactors: {
      list_commits: list_commits_interactor,
      get_committers: get_committers_interactor,
      order_by_commits_count: order_by_commits_count_interactor,
      generate_report: generate_report_interactor
    }).call(repo_name, file_name, asc_order)
  end

  describe '#call' do
    it 'lists commits from specified repository' do
      expect(list_commits_interactor).to receive(:call).with(repo_name)
      subject
    end

    it 'gets committers from listed commits' do
      allow(list_commits_interactor).to receive(:call).and_return('commits')
      expect(get_committers_interactor).to receive(:call).with('commits', include_commits_count: true)
      subject
    end

    it 'orders commits by commits count using specified order' do
      allow(get_committers_interactor).to receive(:call).and_return('committers')
      expect(order_by_commits_count_interactor).to receive(:call).with('committers', asc_order)
      subject
    end

    it 'generates report of committers' do
      allow(order_by_commits_count_interactor).to receive(:call).and_return('committers ordered')
      expect(generate_report_interactor).to receive(:call).with('committers ordered', file_name)
      subject
    end
  end
end
