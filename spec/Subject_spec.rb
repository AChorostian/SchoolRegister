require_relative '../lib/Register.rb'

describe "Checking Subject class initialization" do
  before{
    @subject = Subject.new
  }

  it "Returns not nil while created" do
    expect(@subject).not_to be nil
  end

  it "Returns instance of Subject while created" do
    expect(@subject).to be_instance_of(Subject)
  end

  it "Subject is a subclass of Sequel::Model" do
    expect(@subject).to be_a(Sequel::Model)
  end

  after{
    @subject = nil

  }

end
