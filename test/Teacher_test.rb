require 'test_helper'

describe "Checking Teacher class initialization" do
  before{
    @teacher = Teacher.new
  }

  it "Returns not nil while created" do
    refute_nil @teacher
  end

  it "Returns instance of Teacher while created" do
    assert_instance_of Teacher, @teacher
  end

  it "Teacher is a subclass of Sequel::Model" do
    assert_kind_of(Sequel::Model,@teacher)
  end

  after{
    @teacher = nil
  }
end
