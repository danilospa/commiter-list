require 'pp'
require 'fakefs/safe'
require './app/reports/csv_report'

RSpec.describe Reports::CsvReport do
  let(:items) do
    [
      { name: 'john', age: 20, height: 1.5 },
      { name: 'paul', age: 18, height: 1.2 }
    ]
  end

  subject do
    class Klass
      include Reports::CsvReport

      def attrs
        [:name, :height]
      end
    end

    Klass.new(items)
  end

  describe '#content' do
    it 'returns mapped attributes joined with specified separator' do
      expect(subject.content(',')).to eq ['john,1.5,', 'paul,1.2,']
    end
  end

  describe '#generate' do
    let(:filename) { 'filename' }

    it 'creates a file with specified name' do
      FakeFS.with_fresh do
        subject.generate(filename)
        expect(File.exists?(filename)).to be_truthy
      end
    end

    it 'creates file with correct content' do
      allow(subject).to receive(:content).and_return(['line1', 'line2'])
      FakeFS.with_fresh do
        subject.generate(filename)
        file_content = File.read(filename)
        expect(file_content).to eq "line1\nline2\n"
      end
    end

    it 'uses default separator for data' do
      expect(subject).to receive(:content).with(';').and_return([])
      FakeFS.with_fresh do
        subject.generate(filename)
      end
    end

    it 'uses given separator for data' do
      expect(subject).to receive(:content).with(',').and_return([])
      FakeFS.with_fresh do
        subject.generate(filename, ',')
      end
    end
  end
end
