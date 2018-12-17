require_relative '../lib/Register.rb'


describe "Checking class initialization" do
  before{
    @teacher = Teacher.new
  }

  it "Returns not nil while created" do
    expect(@teacher).not_to be nil
  end

  it "Returns instance of Teacher while created" do
    expect(@teacher).to be_instance_of(Teacher)
  end

  after{
    @teacher = nil
  }

end
