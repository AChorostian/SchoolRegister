require_relative '../lib/Subject.rb'

describe "Checking class initialization" do
  before{
    @subject = Subject.new
  }

  it "Returns not nil while created" do
    expect(@subject).not_to be nil
  end

  it "Returns instance of Subject while created" do
    expect(@subject).to be_instance_of(Subject)
  end

  after{
    @subject = nil
  }

end
