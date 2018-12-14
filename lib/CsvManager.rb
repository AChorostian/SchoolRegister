require 'csv'
require 'fileutils'

class CsvManager

  def self.saveToFile(filename, data, delimiter=',')

    FileUtils.mkdir_p 'data'
    csv = CSV.open('data/'+filename+".csv","w",
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
                headers: true
    )  do |row|
      temp = className.new
      temp.setarray(row)
      Database.add(temp)
    end

  end



end



