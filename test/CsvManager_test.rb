require 'test_helper'

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
      assert_equal @before+count.to_i, @db[table.to_s.to_sym].all.count
      # expect(@db[table.to_s.to_sym].all.count).to eq(@before+count.to_i)
    end
  end

  it "Checks importing from csv files by values" do
    while (line = @test_file.gets) do
      path, table, count = line.split(' ')
      CsvManager.importFromCsv(path, table)
      CsvManager.saveToFile(table.to_s+".csv", @db[table.to_s.to_sym])
      fileOut = File.read('data/'+table.to_s+".csv")
      fileIn = File.read(path)
      assert_includes fileIn, fileOut
      # expect(fileOut).to include(fileIn)
    end
  end

  it "Checks exporting to csv files by count" do
    while (line = @test_file.gets) do
      path, table, count = line.split(' ')
      @before = @db[table.to_s.to_sym].all.count
      CsvManager.importFromCsv(path, table)
      CsvManager.saveToFile(table.to_s+".csv", @db[table.to_s.to_sym])
      fileOut = File.readlines('data/'+table.to_s+".csv").length-1
      assert_equal @before+count.to_i, fileOut
      # expect(fileOut).to eq(@before+count.to_i)
    end
  end

  it "Checks exporting to csv files by values" do
    while (line = @test_file.gets) do
      path, table, count = line.split(' ')
      CsvManager.importFromCsv(path, table)
      CsvManager.saveToFile(table.to_s+".csv", @db[table.to_s.to_sym])
      fileOut = File.readlines('data/'+table.to_s+".csv")
      assert_equal fileOut, File.readlines(path)
      # expect(File.readlines(path)).to match(fileOut)
    end
  end


end
