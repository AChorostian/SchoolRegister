require_relative '../../lib/Register.rb'

describe "Checking Register class initialization" do
  before{
    @register = Register.new
  }

  it "Returns not nil while created" do
    expect(@register).not_to be nil
  end

  it "Returns instance of Register while created" do
    expect(@register).to be_instance_of(Register)
  end
  
  after{
    @register = nil
  }

end

