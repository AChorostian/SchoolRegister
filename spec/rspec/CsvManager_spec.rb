require_relative '../../lib/Register.rb'

describe "Checking import from files" do

  before {
    Database.init
    @db = Database.db
    @test_file = File.new("resources/TestCsv.txt","r")
  }


  it "Checks importing from csv files by count" do
    while (line = @test_file.gets) do
      path, table, count = line.split(' ')
      @before = @db[table.to_s.to_sym].all.count
      CsvManager.importFromCsv(path, table)
      expect(@db[table.to_s.to_sym].all.count).to eq(@before+count.to_i)
    end
  end

  it "Checks importing from csv files by values" do
    while (line = @test_file.gets) do
      path, table, count = line.split(' ')
      CsvManager.importFromCsv(path, table)
      CsvManager.saveToFile(table.to_s+".csv", @db[table.to_s.to_sym])
      fileOut = File.read('data/'+table.to_s+".csv")
      fileIn = File.read(path)
      expect(fileOut).to include(fileIn)
    end
  end

  it "Checks exporting to csv files by count" do
    while (line = @test_file.gets) do
      path, table, count = line.split(' ')
      @before = @db[table.to_s.to_sym].all.count
      CsvManager.importFromCsv(path, table)
      CsvManager.saveToFile(table.to_s+".csv", @db[table.to_s.to_sym])
      fileOut = File.readlines('data/'+table.to_s+".csv").length-1
      expect(fileOut).to eq(@before+count.to_i)
    end
  end

  it "Checks exporting to csv files by values" do
    while (line = @test_file.gets) do
      path, table, count = line.split(' ')
      CsvManager.importFromCsv(path, table)
      CsvManager.saveToFile(table.to_s+".csv", @db[table.to_s.to_sym])
      fileOut = File.readlines('data/'+table.to_s+".csv")
      expect(File.readlines(path)).to match(fileOut)
    end
  end


end
