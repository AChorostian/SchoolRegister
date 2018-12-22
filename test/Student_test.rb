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

  it "Student is associated with :Student table" do
    assert_equal :Student, Student.table_name
  end

  after{
    @new_student = nil
  }
end

describe "Checking Student class functionality" do

  before do
    Database.init
    @new_student = Student.new
    @pre_add_len = Student.dataset.count
    @new_student[:name] = "Jan"
    @new_student[:surname] = "Kowalski"
    @new_student.save
    @post_add_len = Student.dataset.count
  end


  it "Inserting value should increase dataset length" do
    assert_equal @pre_add_len+1, @post_add_len
  end

  it "Checking if value is inserted correctly" do
    assert_equal @new_student, Student.last
  end

  it "Updating value shouldn't increase dataset length" do
    @updated_student = Student.last
    @updated_student[:surname] = "New-Surname"
    @updated_student.save
    assert_equal @post_add_len, Student.dataset.count
  end

  it "Checking if value is updated correctly" do
    @updated_student = Student.last
    @updated_student[:surname] = "New-Surname"
    @updated_student.save
    assert_equal @updated_student, Student.last
  end

  it "Deleting value should decrease dataset length" do
    @removed_student = Student.last
    @removed_student.delete
    assert_equal @post_add_len-1, Student.dataset.count
  end

  it "Checking if value is removed correctly" do
    # skip "need to check that later"
    @removed_student = Student.last
    @removed_student.delete
    refute_equal @removed_student, Student.last
  end

  it "Associating student to note and removing student should remove note" do

    @test_teacher = Teacher.new
    @test_teacher[:name] = "Test"
    @test_teacher[:surname] = "Teacher"
    @test_teacher.save

    @removed_student = Student.last

    @note = Note.new
    @note[:description] = "Description of the note"
    @note[:date] = "01.01.2018"
    @note[:Student_id] = @removed_student[:id]
    @note[:Teacher_id] = @test_teacher[:id]
    @note.save

    @removed_student.delete

    Note.last.wont_equal @note
  end

  it "Associating student to StudentSubject and removing student should remove StudentSubject" do
    @test_teacher = Teacher.new
    @test_teacher[:name] = "Test"
    @test_teacher[:surname] = "Teacher"
    @test_teacher.save

    @test_subject = Subject.new
    @test_subject[:name] = "Test"
    @test_subject[:Teacher_id] = @test_teacher[:id]
    @test_subject.save

    @removed_student = Student.last

    @studentSubject = StudentSubject.new
    @studentSubject[:Student_id] = @removed_student[:id]
    @studentSubject[:Subject_id] = @test_subject[:id]
    @studentSubject.save

    @removed_student.delete

    StudentSubject.last.wont_equal @studentSubject
  end

  it "Checking print function" do
    assert_output(/"2 |Jan |Kowalski\n"/) {@new_student.printline(1)}
  end

  it "Checking print label function" do
    assert_output {Student.printlabels}
  end

  after do
    @test_teacher = nil
    @subject = nil
  end
end

describe "Checking Student class validation" do
  before do
    @new_student = Student.new
    @new_student[:name] = "Jan"
    @new_student[:surname] = "Kowalski"
  end

  it "Checking error when name is nil" do
    @new_student[:name] = nil
    assert_raises (Sequel::ValidationFailed) {@new_student.save}
  end
  it "Checking error when name is too short" do
    @new_student[:name] = "a"
    assert_raises (Sequel::ValidationFailed) {@new_student.save}
  end

  it "Checking error when name is too long" do
    @new_student[:name] = "Testlongnamenamenamenamenamenamenamenamenamenamenamenamename"
    assert_raises (Sequel::ValidationFailed) {@new_student.save}
  end

  it "Checking error when name format is invalid" do
    @new_student[:name] = "D4wid"
    assert_raises (Sequel::ValidationFailed) {@new_student.save}
  end

  it "Checking error when name is not string" do
    @new_student[:name] = 4
    assert_raises (Sequel::ValidationFailed) {@new_student.save}
  end

  it "Checking error when surname is nil" do
    @new_student[:surname] = nil
    assert_raises (Sequel::ValidationFailed) {@new_student.save}
  end

  it "Checking error when surname is too short" do
    @new_student[:surname] = "Ko"
    assert_raises (Sequel::ValidationFailed) {@new_student.save}
  end

  it "Checking error when surname is too long" do
    @new_student[:surname] = "Testlongnamenamenamenamenamenamenamenamenamenamenamenamename"
    assert_raises (Sequel::ValidationFailed) {@new_student.save}
  end


  it "Checking error when surname format is invalid" do
    @new_student[:surname] = "kOwAlSkI"
    assert_raises (Sequel::ValidationFailed) {@new_student.save}
  end

  it "Checking error when surname is not string" do
    @new_student[:surname] = ["Kowalski"]
    assert_raises (Sequel::ValidationFailed) {@new_student.save}
  end
  after do
    @new_student = nil
  end

end
