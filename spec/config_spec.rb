require './app/config'

RSpec.describe Config do
  describe 'constants' do
    CONSTANTS = %w{GITHUB_BASE_URL GITHUB_REPOSITORY}

    CONSTANTS.each do |const|
      it "sets #{const} constant" do
        expect(described_class.const_get(const)).not_to be nil
      end
    end
  end
end
