require './app/interactors/committers/order_by_commits_count'

RSpec.describe Interactors::Committers::OrderByCommitsCount do
  let(:first_committer) do
    { commits_count: 2 }
  end
  let(:second_committer) do
    { commits_count: 1 }
  end

  let(:committers) do
    [first_committer, second_committer]
  end

  subject { described_class.new }

  describe '#call' do
    it 'orders committers by commits count asc when no option is given' do
      expect(subject.call(committers)).to eq [second_committer, first_committer]
    end

    it 'orders committers by commits count desc when asking for it' do
      expect(subject.call(committers, false)).to eq [first_committer, second_committer]
    end
  end
end

