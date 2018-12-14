require 'csv'

class CsvManager

  def self.saveToFile(filename, data, delimiter=',')

    csv = CSV.open(filename+".csv","w",
                   :write_headers => true,
                   :col_sep => delimiter,
                   :headers => data.first.keys
    )
    data.each do |elem|
      csv << elem
    end
  end



end



