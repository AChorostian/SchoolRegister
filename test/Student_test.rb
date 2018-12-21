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

describe "Checking Subject class functionality" do

  before do
    Database.init
    @test_teacher = Teacher.new
    @test_teacher[:name] = "Test"
    @test_teacher[:surname] = "Teacher"
    @test_teacher.save

    @pre_add_len = Subject.dataset.count

    @subject = Subject.new
    @subject[:name] = "Testing subjects"
    @subject[:Teacher_id] = @test_teacher[:id]
    @subject.save

    @post_add_len = Subject.dataset.count
  end


  it "Inserting value should increase dataset length" do
    assert_equal @pre_add_len+1, Subject.dataset.count
  end

  it "Checking if value is inserted correctly" do
    assert_equal @subject, Subject.last
  end

  it "Updating value shouldn't increase dataset length" do
    @updated_subject = Subject.last
    @updated_subject[:name] = "Testing if subject is ok"
    @updated_subject.save
    assert_equal @post_add_len, Subject.dataset.count
  end

  it "Checking if value is updated correctly" do
    @updated_subject = Subject.last
    @updated_subject[:name] = "Testing if subject is ok"
    @updated_subject.save
    assert_equal @updated_subject, Subject.last
  end

  it "Deleting value should decrease dataset length" do
    @removed_subject = Subject.last
    @removed_subject.delete
    assert_equal @post_add_len-1, Subject.dataset.count
  end

  it "Checking if value is removed correctly" do
    # skip "need to check that later"
    @removed_subject = Subject.last
    @removed_subject.delete
    refute_equal @removed_subject, Subject.last
  end

  it "Associating subject to StudentSubject and removing subject should remove StudentSubject" do

    @test_student = Student.new
    @test_student[:name] = "Test"
    @test_student[:surname] = "Teacher"
    @test_student.save

    @removed_subject = Subject.last

    @studentSubject = StudentSubject.new
    @studentSubject[:Student_id] = @test_student[:id]
    @studentSubject[:Subject_id] = @removed_subject[:id]
    @studentSubject.save

    @removed_subject.delete

    StudentSubject.last.wont_equal @studentSubject
  end

  it "Checking print function" do
    assert_output(/"2 |Testing subjects |Test Teacher\n"/) {@subject.printline(1)}
  end

  it "Checking print label function" do
    assert_output {Subject.printlabels}
  end

  after do
    @test_teacher = nil
    @subject = nil
  end
end
