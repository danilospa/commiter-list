require 'pp'
require 'fakefs/safe'
require 'webmock/rspec'
require 'timecop'
require './app'

def stub_commits_request(page, response_body, response_headers)
  stub_request(:get, "#{Config::GITHUB_BASE_URL}/repos/#{Config::GITHUB_REPOSITORY}/commits?page=#{page}").
    to_return(body: response_body.to_json, headers: response_headers)
end

RSpec.describe App do
  let(:commit_from_john) do
    {
      commit: {
        committer: {
          name: 'john',
          email: 'john@gmail.com'
        }
      },
      committer: {
        login: 'john',
        avatar_url: 'johnavatar.jpg'
      }
    }
  end
  let(:commit_from_paul) do
    {
      commit: {
        committer: {
          name: 'paul',
          email: 'paul@gmail.com'
        }
      },
      committer: {
        login: 'paul',
        avatar_url: 'paulavatar.jpg'
      }
    }
  end
  subject { described_class.new }

  before do
    commits_mock_for_first_request = [commit_from_john]
    header_mock_for_first_request = { 'link' => ['<github_api_url?page=1>; rel="next"'] }
    commits_mock_for_second_request = [commit_from_paul, commit_from_john]
    header_mock_for_second_request = { 'link' => [''] }

    stub_commits_request(0, commits_mock_for_first_request, header_mock_for_first_request)
    stub_commits_request(1, commits_mock_for_second_request, header_mock_for_second_request)
  end

  it 'creates file with correct content' do
    Timecop.freeze('2018-01-01 00:00:00 -0000') do
      FakeFS.with_fresh do
        subject.create_report
        content = File.read('dinda-com-brbraspag-rest-2018-01-01-000000-utc.txt')
        expect(content).to eq "john;john@gmail.com;john;johnavatar.jpg;2;\npaul;paul@gmail.com;paul;paulavatar.jpg;1;\n"
      end
    end
  end
end
