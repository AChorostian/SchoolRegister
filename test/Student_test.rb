require 'test_helper'

describe "Checking Student class initialization" do
  before{
    @new_student = Student.new
  }

  it "Returns not nil while created" do
    refute_nil @new_student
  end

  it "Returns instance of Student while created" do
    assert_instance_of Student, @new_student
  end

  it "Student is a subclass of Sequel::Model" do
    assert_kind_of(Sequel::Model,@new_student)
  end

  after{
    @new_student = nil
  }
end