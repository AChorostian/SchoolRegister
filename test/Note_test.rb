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

  it "Note is associated with :Note table" do
    assert_equal :Note, Note.table_name
  end

  after{
    @new_note = nil
  }
end

describe "Checking Note Class functionality" do

  before {
    @test_student = Student.new
    @test_student[:name] = "Test"
    @test_student[:surname] = "Student"
    @test_student.save

    @test_teacher = Teacher.new
    @test_teacher[:name] = "Test"
    @test_teacher[:surname] = "Teacher"
    @test_teacher.save

    @pre_add_len = Note.dataset.count
    @note = Note.new
    @note[:description] = "Description of the note"
    @note[:date] = "01.01.2018"
    @note[:Student_id] = @test_student[:id]
    @note[:Teacher_id] = @test_teacher[:id]
    @note.save

    @post_add_len = Note.dataset.count
  }



  it "Inserting value should increase dataset length" do
    assert_equal @pre_add_len+1, Note.dataset.count
  end

  it "Checking if value is inserted correctly" do
    assert_equal @note, Note.last
  end


  it "Updating value shouldn't increase dataset length" do
    @updated_note = Note.last
    @updated_note[:description] = "Testing if Note is ok"
    @updated_note.save
    assert_equal @post_add_len, Note.dataset.count
  end

  it "Checking if value is updated correctly" do
    @updated_note = Note.last
    @updated_note[:description] = "Testing if Note is ok"
    @updated_note.save
    assert_equal @updated_note, Note.last
  end

  it "Deleting value should decrease dataset length" do
    # skip("no mocks implemented")
    @removed_note = Note.last
    @removed_note.delete
    assert_equal @post_add_len-1, Note.dataset.count
  end

  it "Checking if value is removed correctly" do
    # skip("no mocks implemented")
    @removed_note = Note.last
    @removed_note.delete
    Note.last.wont_equal @removed_note
  end

  it "Checking print function" do
    assert_output(/"2 |01.01.2018 |Test Teacher|Description of the note\n"/) {@note.printline(1)}
  end

  it "Checking print label function" do
    assert_output {Note.printlabels}
  end



  after {
    @test_teacher = nil
    @test_student = nil
    @note = nil
  }

end

describe "Negative cases - Note" do

  before do
    Database.init
    @note = Note.new
  end

  it "Assigning id of non existing Teacher" do
    @note[:Teacher_id] = 1
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  it "Assigning id of non existing Student" do
    @note[:Student_id] = 1
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  after do
    @note = nil
  end

end

describe "Checking Note Class validation" do

  before {
    @test_student = Student.new
    @test_student[:name] = "Test"
    @test_student[:surname] = "Student"
    @test_student.save

    @test_teacher = Teacher.new
    @test_teacher[:name] = "Test"
    @test_teacher[:surname] = "Teacher"
    @test_teacher.save

    @note = Note.new
    @note[:description] = "Description"
    @note[:date] = "01.01.2019"
    @note[:Teacher_id] = @test_teacher[:id]
    @note[:Student_id] = @test_student[:id]

  }


  it "Checking error when description is nil" do
    @note[:description] = nil
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  it "Checking error when description is too short" do
    @note[:description] = "D"
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  it "Checking error when description is too long" do
    long_description = "Too long description " * 50
    @note[:description] = long_description
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  it "Checking error when description is not string" do
    @note[:description] = 1
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  it "Checking error when date is in invalid format" do
    @note[:date] = "2019.01.01"
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  it "Checking error when date is nil" do
    @note[:date] = nil
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  it "Checking error when teacher_id is nil" do
    @note[:Teacher_id] = nil
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  it "Checking error when teacher_id is not integer" do
    @note[:Teacher_id] = "test"
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  it "Checking error when teacher_id is negative integer" do
    @note[:Teacher_id] = -1
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  it "Checking error when student_id is nil" do
    @note[:Student_id] = nil
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  it "Checking error when student_id is not integer" do
    @note[:Student_id] = "test"
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  it "Checking error when student_id is negative integer" do
    @note[:Student_id] = -1
    assert_raises (Sequel::ValidationFailed) {@note.save}
  end

  after{
    @note = nil
    @test_teacher = nil
    @test_student = nil
  }

end