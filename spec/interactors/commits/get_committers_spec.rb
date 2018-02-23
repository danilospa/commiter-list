require './app/interactors/commits/get_committers'

RSpec.describe Interactors::Commits::GetCommitters do
  let(:first_committer) do
    { name: 'committer 1', email: 'email 1' }
  end
  let(:second_committer) do
    { name: 'committer 2', email: 'email 2' }
  end

  let(:first_commit) do
    {
      commit: {
        committer: first_committer
      },
      committer: {
        login: 'login for committer 1',
        avatar_url: 'avatar for committer 1'
      }
    }
  end
  let(:second_commit) do
    {
      commit: {
        committer: second_committer
      },
      committer: {
        login: 'login for committer 2',
        avatar_url: 'avatar for committer 2'
      }
    }
  end
  let(:third_commit) do
    {
      commit: {
        committer: first_committer
      },
      committer: nil
    }
  end

  let(:commits) do
    [first_commit, second_commit, third_commit]
  end

  subject { described_class.new }

  describe '#call' do
    it 'gets committers from commits with login and avatar_url' do
      expect(subject.call(commits)).to eq [
        first_committer.merge(login: 'login for committer 1', avatar_url: 'avatar for committer 1'),
        second_committer.merge(login: 'login for committer 2', avatar_url: 'avatar for committer 2')
      ]
    end

    it 'gets committers from commits with login, avatar_url and commits_count when sending it as true' do
      expect(subject.call(commits, include_commits_count: true)).to eq [
        first_committer.merge(login: 'login for committer 1', avatar_url: 'avatar for committer 1', commits_count: 2),
        second_committer.merge(login: 'login for committer 2', avatar_url: 'avatar for committer 2', commits_count: 1)
      ];
    end
  end
end

