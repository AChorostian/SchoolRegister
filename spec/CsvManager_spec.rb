require_relative '../lib/CsvManager.rb'

describe "Checking import from files" do

  before {
    @file = File.new("resources/TestCsv.txt","r")
  }


  it "Test importing from csv files" do
    skip("Not implemented yet")
    while (line = @file.gets) do
      filepath, className = line.split(' ')
      length = File.open(filepath).readlines().length-1
      result = CsvManager.importFromCsv(filepath,className)
      expect(result.length).to eq(length)
    end
  end


end
