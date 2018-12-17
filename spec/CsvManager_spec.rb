require_relative '../lib/CsvManager.rb'

describe "Checking import from files" do

  before {
    @db = Sequel.sqlite("database.db")
    Database
  }


  it "Test importing from csv files" do
      przed = @db[:Student].all.count
      CsvManager.importFromCsv("data/students.csv",Student)
      expect(@db[:Student].all.count).to eq(przed+20)
  end


end
