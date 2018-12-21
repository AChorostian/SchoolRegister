require 'test_helper'

describe "Checking Database class initialization" do
  before{
    @database = Database.new
  }

  it "Returns not nil while created" do
    refute_nil @database
  end

  it "Returns instance of Database while created" do
    assert_instance_of Database, @database
  end

  after{
    @database = nil
  }
end
