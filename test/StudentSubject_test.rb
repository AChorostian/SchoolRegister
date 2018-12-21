require 'test_helper'

describe "Checking StudentSubject class initialization" do
  before{
    @student_subject = StudentSubject.new
  }

  it "Returns not nil while created" do
    refute_nil @student_subject
  end

  it "Returns instance of StudentSubject while created" do
    assert_instance_of StudentSubject, @student_subject
  end

  it "StudentSubject is a subclass of Sequel::Model" do
    assert_kind_of(Sequel::Model,@student_subject)
  end

  after{
    @student_subject = nil
  }
end
