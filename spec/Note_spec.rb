require_relative '../lib/Note.rb'

describe "Checking class initialization" do
  before{
    @note = Note.new
  }

  it "Returns not nil while created" do
    expect(@note).not_to be nil
  end

  it "Returns instance of Note while created" do
    expect(@note).to be_instance_of(Note)
  end

  after{
    @note = nil
  }

end
