require_relative '../lib/Register.rb'


describe "Checking Teacher class initialization" do
  before{
    @teacher = Teacher.new
  }

  it "Returns not nil while created" do
    expect(@teacher).not_to be nil
  end

  it "Returns instance of Teacher while created" do
    expect(@teacher).to be_instance_of(Teacher)
  end

  it "Teacher is a subclass of Sequel::Model" do
    expect(@teacher).to be_a(Sequel::Model)
  end

  after{
    @teacher = nil
  }

end
