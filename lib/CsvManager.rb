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


    CSV.foreach(filepath,
                :headers =>true,
                :col_sep => delimiter
    )  do |row|
      temp = className.new
      temp.setarray(row)
      Database.add(temp)
    end

  end



end



