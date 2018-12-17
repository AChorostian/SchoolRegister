require_relative '../lib/Register.rb'


describe "Checking Note class initialization" do
  before{
    @note = Note.new
  }

  it "Returns not nil while created" do
    expect(@note).not_to be nil
  end

  it "Returns instance of Note while created" do
    expect(@note).to be_instance_of(Note)
  end

  it "Note is a subclass of Sequel::Model" do
    expect(@note).to be_a(Sequel::Model)
  end

  after{
    @note = nil

  }

end
