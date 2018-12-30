require_relative '../../lib/Register.rb'

describe "Checking Register class initialization" do
  before{
    @note = Register.new
  }

  it "Returns not nil while created" do
    expect(@note).not_to be nil
  end

  it "Returns instance of Register while created" do
    expect(@note).to be_instance_of(Register)
  end
  
  after{
    @note = nil
  }

end

describe "Testy" do
    it "tru tru" do
        expect(false).not_to be_truthy
    end
end
