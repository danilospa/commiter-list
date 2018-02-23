require './app/interactors/committers/generate_report'

RSpec.describe Interactors::Committers::GenerateReport do
  let(:committers) { 'committers' }
  let(:filename) { 'filename' }

  let(:report) do
    klass = double('Report')
    allow(klass).to receive(:new).and_return(klass)
    allow(klass).to receive(:generate)
    klass
  end

  subject { described_class.new(report: report).call(committers, filename) }

  describe '#call' do
    it 'instanciates report for given committers' do
      expect(report).to receive(:new).with(committers)
      subject
    end

    it 'generates report with given filename' do
      expect(report).to receive(:generate).with(filename)
      subject
    end
  end
end
