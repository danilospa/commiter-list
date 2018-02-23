module Reports
  module CsvReport
    def initialize(data)
      @data = data
    end

    def content(separator)
      @data.map do |item|
        "#{item.fetch_values(*attrs).join(separator)}#{separator}"
      end
    end

    def generate(filename, separator = ';')
      File.open(filename, 'w') do |f|
        content(separator).each { |line| f.puts(line) }
      end
    end
  end
end
