require 'csv'
require 'fileutils'

class CsvManager

  def self.saveToFile(filename, data, delimiter=',')

    if (!data.is_a?(Array))
      raise ArgumentError, "Wrong data to export to CSV file!"
    end
    if (!(filename =~ /[^\0]+/))
      raise ArgumentError, "Wrong data"
    end

    FileUtils.mkdir_p 'data'
    csv = CSV.open('data/'+filename,"w",
                   :write_headers => true,
                   :col_sep => delimiter,
                   :headers => data.first.keys
    )
    data.each do |elem|
      csv << elem
    end
  end

  def self.importFromCsv(filepath,className, delimiter=',')


    data = CSV.read(filepath, encoding:"UTF-8",
                    headers: true,
                    header_converters: :symbol,
                    converters: :all).map do |row| row.to_hash end
    data.each do |row|
      temp = className.new
      temp.sethash(row)
      Database.add(temp)
    end

  end



end



