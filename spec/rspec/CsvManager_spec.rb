require_relative '../../lib/Register.rb'

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

describe "Checking CSVManager negative cases" do

  before {
    Database.init
    @db = Database.db
    @test_file = File.new("resources/TestCsv.txt","r")
  }

  it "Checks importing from csv file when path is wrong" do
    expect{CsvManager.importFromCsv("wrong/path/to/file.csv", Student)}.to raise_error(ArgumentError)
  end

  it "Checks importing from csv file when file is empty" do
    @pre = Student.dataset.count
    CsvManager.importFromCsv("resources/EmptyFile.csv", Student)
    expect(Student.dataset.count).to eq(@pre)
  end

  it "Checks importing from csv file when file is not csv" do
    expect{CsvManager.importFromCsv("resources/NotACsvFile.txt", Student)}.to raise_error(ArgumentError)
  end

  it "Checks exporting to csv file when path is wrong" do
    expect{CsvManager.saveToFile("wrong/path/for/file.csv", @db[:Student])}.to raise_error(ArgumentError)
  end

  it "Checks exporting to csv file when table name is wrong" do
    expect{CsvManager.saveToFile("wrong/path/for/file.csv", @db[:WrongName])}.to raise_error(Sequel::DatabaseError)
  end


end
