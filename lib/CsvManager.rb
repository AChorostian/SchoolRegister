require 'csv'
require 'fileutils'

class CsvManager

  def self.saveToFile(filename, data)

    if (!data.is_a?(Array))
      raise ArgumentError, "Wrong data to export to CSV file!"
    end
    if (!(filename =~ /[^\0]+/))
      raise ArgumentError, "Wrong data"
    end

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
      case className
      when "Student"
        className = Student
      when "Teacher"
        className = Teacher
      when "Note"
        className = Note
      when "Subject"
        className = Subject
      when "StudentSubject"
        className = StudentSubject
      when "Grade"
        className = Grade
      end
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