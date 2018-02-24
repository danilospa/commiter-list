require './app/config.rb'
require './app/organizers/reports/export_committers_ordered_by_commits_count'

class App
  def create_report
    repository = Config::GITHUB_REPOSITORY
    filename = "#{repository}-#{Time.now}".downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') + '.txt'
    asc_order = false

    Organizers::Reports::ExportCommittersOrderedByCommitsCount.build.call(repository, filename, asc_order)
  end
end
