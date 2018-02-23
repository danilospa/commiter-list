require './app/reports/csv_report'

module Reports
  class Committers
    include CsvReport

    def attrs
      [:name, :email, :login, :avatar_url, :commits_count]
    end
  end
end
