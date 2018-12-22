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

  it "Grade is associated with :Grade table" do
    assert_equal :Grade, Grade.table_name
  end

  after{
    @new_grade = nil
  }
end
describe "Checking Grade class functionality" do
  before{
    Database.init
    @test_student = Student.new
    @test_student[:name] = "Test"
    @test_student[:surname] = "Student"
    @test_student.save

    @test_teacher = Teacher.new
    @test_teacher[:name] = "Test"
    @test_teacher[:surname] = "Teacher"
    @test_teacher.save

    @test_subject = Subject.new
    @test_subject[:name] = "Test"
    @test_subject[:Teacher_id] = @test_teacher[:id]
    @test_subject.save


    @test_studentSubject = StudentSubject.new
    @test_studentSubject[:Student_id] = @test_student[:id]
    @test_studentSubject[:Subject_id] = @test_subject[:id]
    @test_studentSubject.save

    @pre_add_len = Grade.dataset.count

    @grade = Grade.new
    @grade[:grade] = 5
    @grade[:comment] = "Za projekt z ruby"
    @grade[:date] = "08.01.2019"
    @grade[:StudentSubject_id] =@test_studentSubject[:id]
    @grade.save

    @post_add_len = Subject.dataset.count
  }


  it "Inserting value should increase dataset length" do
    assert_equal @pre_add_len+1, Grade.dataset.count
  end

  it "Checking if value is inserted correctly" do
    assert_equal @grade, Grade.last
  end

  it "Updating value shouldn't increase dataset length" do
    @updated_grade= Grade.last
    @updated_grade[:grade] = 6
    @updated_grade.save
    assert_equal @post_add_len, Grade.dataset.count
  end

  it "Checking if value is updated correctly" do
    @updated_grade = Grade.last
    @updated_grade[:grade] = 6
    @updated_grade.save
    assert_equal @updated_grade, Grade.last
  end

  it "Deleting value should decrease dataset length" do
    # skip("no mocks implemented")
    @removed_grade = Grade.last
    @removed_grade.delete
    assert_equal @post_add_len-1, Grade.dataset.count
  end

  it "Checking if value is removed correctly" do
    # skip("no mocks implemented")
    @removed_grade = Grade.last
    @removed_grade.delete
    Grade.last.wont_equal @removed_grade
  end

  it "Checking print function" do
    assert_output(/"2 |5 |Za projekt z ruby|08.01.2019\n"/) {@grade.printline(1)}
  end

  it "Checking print label function" do
    assert_output {Grade.printlabels}
  end

  after{
    @test_teacher = nil
    @test_subject = nil
    @test_student = nil
    @grade = nil
    @test_studentSubject = nil
  }

end

describe "Negative cases - Grade"  do
  before do
    Database.init
    @grade = Grade.new
    @grade[:grade] = 5
    @grade[:comment] = "Za projekt z ruby"
    @grade[:date] = "08.01.2019"
  end

  it "Assigning id of non existing StudentSubject" do
    @grade[:StudentSubject_id] = 1
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end

  after do
    @grade = nil
  end
end


describe "Checking Grade class functionality" do
  before{
    Database.init
    @test_student = Student.new
    @test_student[:name] = "Test"
    @test_student[:surname] = "Student"
    @test_student.save

    @test_teacher = Teacher.new
    @test_teacher[:name] = "Test"
    @test_teacher[:surname] = "Teacher"
    @test_teacher.save

    @test_subject = Subject.new
    @test_subject[:name] = "Test"
    @test_subject[:Teacher_id] = @test_teacher[:id]
    @test_subject.save


    @test_studentSubject = StudentSubject.new
    @test_studentSubject[:Student_id] = @test_student[:id]
    @test_studentSubject[:Subject_id] = @test_subject[:id]
    @test_studentSubject.save


    @grade = Grade.new
    @grade[:grade] = 5
    @grade[:comment] = "Za projekt z ruby"
    @grade[:date] = "08.01.2019"
    @grade[:StudentSubject_id] =@test_studentSubject[:id]

  }


  it "Checking error when grade is nil" do
    @grade[:grade] = nil
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end

  it "Checking error when grade is not integer" do
    @grade[:grade] = "Dwója"
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end

  it "Checking error when grade is not between 1 and 6" do
    @grade[:grade] = 7
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end

  it "Checking error when comment is nil" do
    @grade[:comment] = nil
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end

  it "Checking error when comment is not string" do
    @grade[:comment] = ["Praca", "Praca"]
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end

  it "Checking error when comment is too short" do
    @grade[:comment] = "T"
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end

  it "Checking error when comment is too long" do
    long_comment = "Too long comment " * 50
    @grade[:comment] = long_comment
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end

  it "Checking error when date is nil" do
    @grade[:date] = nil
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end

  it "Checking error when date has invalid format" do
    @grade[:date] = "2019.01.01"
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end

  it "Checking error when date is not string" do
    @grade[:date] = 17
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end

  it "Checking error when studentSubject_id is nil" do
    @grade[:StudentSubject_id] = nil
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end

  it "Checking error when studentSubject_id is not integer" do
    @grade[:StudentSubject_id] = "test"
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end

  it "Checking error when studentSubject_id is negative integer" do
    @grade[:StudentSubject_id] = -1
    assert_raises (Sequel::ValidationFailed) {@grade.save}
  end


  after{
    @test_teacher = nil
    @test_subject = nil
    @test_student = nil
    @grade = nil
    @test_studentSubject = nil
  }


end