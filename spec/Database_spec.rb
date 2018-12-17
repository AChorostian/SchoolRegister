require_relative '../lib/Register.rb'

describe "Checking class initialization" do
  before{
    @data = Database.new
  }

  it "Returns not nil while created" do
    expect(@data).not_to be nil
  end

  it "Returns instance of Database while created" do
    expect(@data).to be_instance_of(Database)
  end

  after{
    @data = nil
  }

end
