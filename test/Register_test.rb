require 'test_helper'
describe "Checking Register class initialization" do
  before{
    @register = Register.new
  }

  it "Returns not nil while created" do
    refute_nil @register
  end

  it "Returns instance of Register while created" do
    assert_instance_of Register, @register
  end

  after{
    @register = nil
  }

end

