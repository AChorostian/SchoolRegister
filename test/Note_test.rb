require 'test_helper'

describe "Checking Note class initialization" do
  before{
    @new_note = Note.new
  }

  it "Returns not nil while created" do
    refute_nil @new_note
  end

  it "Returns instance of Note while created" do
    assert_instance_of Note, @new_note
  end

  it "Note is a subclass of Sequel::Model" do
    assert_kind_of(Sequel::Model,@new_note)
  end

  after{
    @new_note = nil
  }
end
