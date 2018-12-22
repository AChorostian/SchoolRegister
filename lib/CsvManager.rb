require 'csv'
require 'fileutils'

class CsvManager

    def self.saveToFile(filename,className)

        FileUtils.mkdir_p "data/"

        data = className.all

        data.each do |elem|
          elem.delete(:id)
        end

        CSV.open("data/"+filename,"w", encoding: "UTF-8",
                       :write_headers => true,
                       :headers => data.first.keys
        ) do |csv|
            data.each do |elem|
              csv << elem
            end
        end
    end

    def self.importFromCsv(filepath,className)

        options = { encoding:"UTF-8", headers: true, col_sep: ','}

        if className.is_a? String
            className = Module.const_get(className)
        end

        CSV.read(filepath, options).map do |row|
            h = row.to_hash
            h.delete("id")
            className.create(h)
        end

    end


end