require 'test_helper'

describe "Test studensts" do

  before do
    @student = Student.new
  end

  it "Checking if instance is created" do
    assert_instance_of Student, @student
  end

end