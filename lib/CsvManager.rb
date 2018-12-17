require 'csv'
require 'fileutils'

class CsvManager

  def self.saveToFile(filename, data)
      raise ArgumentError, "Wrong data to export to CSV file!" unless data.is_a?(Array)
      raise ArgumentError, "Wrong data" unless filename =~ /[^\0]+/

      FileUtils.mkdir_p 'data'

      data.each do |elem|
        elem.delete(:id)
      end

      csv = CSV.open('data/'+filename,"w",
                     :write_headers => true,
                     :headers => data.first.keys
      )
      data.each do |elem|
        csv << elem
      end
  end

  def self.importFromCsv(filepath,className, delimiter=',')

    if (className.is_a?(String))
      className = Module.const_get(className)
    end

    returnArray = []
    data = CSV.read(filepath, encoding:"UTF-8",
                    headers: true,
                    :col_sep => delimiter,
                    header_converters: :symbol,
                    converters: :all).map do |row| row.to_hash end
    data.each do |row|
      temp = className.new
      row[:id] = nil
      temp.sethash(row)
      returnArray.push(temp)
    end
    return returnArray

  end


end