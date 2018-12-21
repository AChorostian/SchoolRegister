require 'test_helper'

describe "Checking Subject class initialization" do
  before{
    @new_subject = Subject.new
  }

  it "Returns not nil while created" do
    refute_nil @new_subject
  end

  it "Returns instance of Subject while created" do
    assert_instance_of Subject, @new_subject
  end

  it "Subject is a subclass of Sequel::Model" do
    assert_kind_of(Sequel::Model,@new_subject)
  end

  after{
    @new_subject = nil
  }
end
