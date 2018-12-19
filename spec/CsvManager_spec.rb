require_relative '../lib/Register.rb'

describe "Checking import from files" do

  before {
    Database.init
    @db = Database.db
    @test_file = File.new("resources/TestCsv.txt","r")
  }


  it "Checks importing from csv files" do
    while (line = @test_file.gets) do
      path, table, count = line.split(' ')
      @before = @db[table.to_s.to_sym].all.count
      CsvManager.importFromCsv(path, table)
      expect(@db[table.to_s.to_sym].all.count).to eq(@before+count.to_i)
    end
  end

  it "Checks exporting to csv files" do

  end


end
