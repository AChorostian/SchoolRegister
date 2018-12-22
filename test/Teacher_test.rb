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

  it "Teacher is associated with :Teacher table" do
    assert_equal :Teacher, Teacher.table_name
  end

  after{
    @teacher = nil
  }
end


describe "Checking Teacher class functionality" do
  before do
    Database.init
    @new_teacher = Teacher.new
    @pre_add_len = Teacher.dataset.count
    @new_teacher[:name] = "Jan"
    @new_teacher[:surname] = "Kowalski"
    @new_teacher.save
    @post_add_len = Teacher.dataset.count
  end

  it "Inserting value should increase dataset length" do
    assert_equal @pre_add_len+1, Teacher.dataset.count
  end

  it "Checking if value is inserted correctly" do
    assert_equal @new_teacher, Teacher.last
  end

  it "Updating value shouldn't increase dataset length" do
    @updated_teacher = Teacher.last
    @updated_teacher[:surname] = "New-Surname"
    @updated_teacher.save
    assert_equal @post_add_len, Teacher.dataset.count
  end

  it "Checking if value is updated correctly" do
    @updated_teacher = Teacher.last
    @updated_teacher[:surname] = "New-Surname"
    @updated_teacher.save
    assert_equal @updated_teacher, Teacher.last
  end

  it "Deleting value should decrease dataset length" do
    # skip("no mocks implemented")
    @removed_teacher = Teacher.last
    @removed_teacher.delete
    assert_equal @post_add_len-1, Teacher.dataset.count
  end

  it "Checking if value is removed correctly" do
    # skip("no mocks implemented")
    @removed_teacher = Teacher.last
    @removed_teacher.delete
    refute_equal @removed_teacher, Teacher.last
  end

  it "Associating teacher to subject and removing teacher should remove subject" do
    @removed_teacher = Teacher.last

    @subject = Subject.new
    @subject[:name] = "Testing subjects"
    @subject[:Teacher_id] = @removed_teacher[:id]
    @subject.save

    @removed_teacher.delete

    refute_equal @subject, Subject.last
  end

  it "Associating teacher to note and removing teacher should remove note" do

    @test_student = Student.new
    @test_student[:name] = "Test"
    @test_student[:surname] = "Student"
    @test_student.save

    @removed_teacher = Teacher.last

    @note = Note.new
    @note[:description] = "Description of the note"
    @note[:date] = "01.01.2018"
    @note[:Student_id] = @test_student[:id]
    @note[:Teacher_id] = @removed_teacher[:id]
    @note.save

    @removed_teacher.delete
    refute_equal @note, Note.last

  end

  it "Checking print function" do
    assert_output(/"2 |Jan |Kowalski\n"/) {@new_teacher.printline(1)}
  end

  it "Checking print label function" do
    assert_output {Teacher.printlabels}
  end

  after do
    @new_teacher = nil
  end
end

describe "Checking Teacher class validation" do
  before do
    @new_teacher = Teacher.new
    @new_teacher[:name] = "Jan"
    @new_teacher[:surname] = "Kowalski"
  end

  it "Checking error when name is nil" do
    @new_teacher[:name] = nil
    assert_raises (Sequel::ValidationFailed) {@new_teacher.save}
  end

  it "Checking error when name is too short" do
    @new_teacher[:name] = "D"
    assert_raises (Sequel::ValidationFailed) {@new_teacher.save}

  end

  it "Checking error when name is too long" do
    @new_teacher[:name] = "Testlongnamenamenamenamenamenamenamenamenamenamenamenamenamenamenamename"
    assert_raises (Sequel::ValidationFailed) {@new_teacher.save}
  end

  it "Checking error when name format is invalid" do
    @new_teacher[:name] = "D4wid"
    assert_raises (Sequel::ValidationFailed) {@new_teacher.save}
  end

  it "Checking error when name is not string" do
    @new_teacher[:name] = 4
    assert_raises (Sequel::ValidationFailed) {@new_teacher.save}
  end

  it "Checking error when surname is nil" do
    @new_teacher[:surname] = nil
    assert_raises (Sequel::ValidationFailed) {@new_teacher.save}
  end

  it "Checking error when surname is too short" do
    @new_teacher[:surname] = "Ko"
    assert_raises (Sequel::ValidationFailed) {@new_teacher.save}
  end

  it "Checking error when surname is too long" do
    @new_teacher[:surname] = "Testlongnamenamenamenamenamenamenamenamenamenamenamenamenamenamenamename"
    assert_raises (Sequel::ValidationFailed) {@new_teacher.save}
  end

  it "Checking error when surname format is invalid" do
    @new_teacher[:surname] = "kOwAlSkI"
    assert_raises (Sequel::ValidationFailed) {@new_teacher.save}
  end

  it "Checking error when surname is not string" do
    @new_teacher[:surname] = ["Kowalski"]
    assert_raises (Sequel::ValidationFailed) {@new_teacher.save}
  end


  after do
    @new_teacher = nil
  end

end
