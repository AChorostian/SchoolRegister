require 'test_helper'

describe "Checking CSVManager Functionality" do

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

describe "Checking CSVManager negative cases" do

  before {
    Database.init
    @db = Database.db
    @test_file = File.new("resources/TestCsv.txt","r")
  }

  it "Checks importing from csv file when path is wrong" do
    assert_raises(ArgumentError) {CsvManager.importFromCsv("wrong/path/to/file.csv", Student)}
  end

  it "Checks importing from csv file when file is empty" do
    @pre = Student.dataset.count
    CsvManager.importFromCsv("resources/EmptyFile.csv", Student)
    assert_equal @pre, Student.dataset.count
  end

  it "Checks importing from csv file when file is not csv" do
    assert_raises(ArgumentError) {CsvManager.importFromCsv("resources/NotACsvFile.txt", Student)}
  end

  it "Checks exporting to csv file when path is wrong" do
    assert_raises(ArgumentError) {CsvManager.saveToFile("wrong/path/for/file.csv", @db[:Student])}
  end

  it "Checks exporting to csv file when table name is wrong" do
    assert_raises(Sequel::DatabaseError) {CsvManager.saveToFile("wrong/path/for/file.csv", @db[:WrongName])}
  end


end
