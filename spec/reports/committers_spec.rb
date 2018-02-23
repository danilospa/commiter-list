require './app/reports/committers'

RSpec.describe Reports::Committers do
  subject { described_class.new([]) }

  describe '#attrs' do
    it 'set correct attributes from data to be exported' do
      expect(subject.attrs).to eq [:name, :email, :login, :avatar_url, :commits_count]
    end
  end
end
