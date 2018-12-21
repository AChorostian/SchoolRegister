require 'test_helper'

describe "Checking Grade class initialization" do
  before{
    @new_grade = Grade.new
  }

  it "Returns not nil while created" do
    refute_nil @new_grade
  end

  it "Returns instance of Grade while created" do
    assert_instance_of Grade, @new_grade
  end

  it "Grade is a subclass of Sequel::Model" do
    assert_kind_of(Sequel::Model,@new_grade)
  end

  after{
    @new_grade = nil
  }
end
