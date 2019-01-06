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

  it "StudentSubject is associated with :StudentSubject table" do
    assert_equal :StudentSubject, StudentSubject.table_name
  end

  after{
    @student_subject = nil
  }
end
describe "Checking StudentSubject Class functionality" do

  before {
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
    @test_subject[:name] = "Testing subject"
    @test_subject[:Teacher_id] = @test_teacher[:id]
    @test_subject.save

    @pre_add_len = StudentSubject.dataset.count

    @studentSubject = StudentSubject.new
    @studentSubject[:Student_id] = @test_student[:id]
    @studentSubject[:Subject_id] = @test_subject[:id]
    @studentSubject.save

    @post_add_len = StudentSubject.dataset.count
  }

  it "Inserting value should increase dataset length" do
    assert_equal @pre_add_len+1, StudentSubject.dataset.count
  end

  it "Checking if value is inserted correctly" do
    assert_equal @studentSubject, StudentSubject.last
  end

  it "Updating value shouldn't increase dataset length" do
    @updated_studentSubject = StudentSubject.last

    @test_update_student = Student.new
    @test_update_student[:name] = "Update"
    @test_update_student[:surname] = "Test-Student"
    @test_update_student.save

    @updated_studentSubject[:Student_id] = @test_update_student[:id]
    @updated_studentSubject.save
    assert_equal @post_add_len, StudentSubject.dataset.count
  end

  it "Checking if value is updated correctly" do
    @updated_studentSubject = StudentSubject.last

    @test_update_student = Student.new
    @test_update_student[:name] = "Update"
    @test_update_student[:surname] = "Test-Student"
    @test_update_student.save

    @updated_studentSubject[:Student_id] = @test_update_student[:id]
    @updated_studentSubject.save
    assert_equal @updated_studentSubject, StudentSubject.last
  end

  it "Deleting value should decrease dataset length" do
    # skip("no mocks implemented")
    @removed_studentSubject = StudentSubject.last
    @removed_studentSubject.delete
    assert_equal @post_add_len-1, StudentSubject.dataset.count
  end

  it "Checking if value is removed correctly" do
    # skip("no mocks implemented")
    @removed_studentSubject = StudentSubject.last
    @removed_studentSubject.delete
    refute_equal @removed_studentSubject, StudentSubject.last
  end

  it "Associating studentSubject to grade and removing studentSubject should remove grade" do

    @removed_studentSubject = StudentSubject.last

    @grade = Grade.new
    @grade[:grade] = 5
    @grade[:comment] = "Za projekt z ruby"
    @grade[:date] = "08.01.2019"
    @grade[:StudentSubject_id] = @removed_studentSubject[:id]
    @grade.save

    @removed_studentSubject.delete

    Grade.last.wont_equal @grade
  end

  it "Checking print function" do
    assert_output(/"2 |Testing subject |Test Teacher\n"/) {@studentSubject.printline(1)}
  end

  it "Checking print label function" do
    assert_output {StudentSubject.printlabels}
  end


  after{
    @test_teacher = nil
    @test_subject = nil
    @test_student = nil
    @test_update_student = nil
    @studentSubject = nil
  }
end

describe "Negative cases - StudentSubject" do

  before() do
    Database.init
    @studentSubject = StudentSubject.new
  end

  it "Assigning id of non existing Student" do
    @studentSubject[:Student_id] = 1
    assert_raises (Sequel::ValidationFailed) {@studentSubject.save}
  end

  it "Assigning id of non existing Subject" do
    @studentSubject[:Subject_id] = 1
    assert_raises (Sequel::ValidationFailed) {@studentSubject.save}
  end

  after() do
    @studentSubject = nil
  end


end
describe "Statistics - StudentSubject" do
  before(:each) do
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
    @test_subject[:name] = "Testing subject"
    @test_subject[:Teacher_id] = @test_teacher[:id]
    @test_subject.save

    @studentSubject = StudentSubject.new
    @studentSubject[:Student_id] = @test_student[:id]
    @studentSubject[:Subject_id] = @test_subject[:id]
    @studentSubject.save

    @grade = Grade.new
    @grade[:grade] = 5
    @grade[:comment] = "Za projekt z ruby"
    @grade[:date] = "08.01.2019"
    @grade[:StudentSubject_id] = @studentSubject[:id]
    @grade.save
  end

  it "Checking average of grades - one grade" do
    assert_equal 5.0, @studentSubject.average_grades
  end
  it "Checking average of grades - two grades" do
    @new_grade = Grade.new
    @new_grade[:grade] = 2
    @new_grade[:comment] = "Za projekt z ruby2"
    @new_grade[:date] = "08.01.2019"
    @new_grade[:StudentSubject_id] = @studentSubject[:id]
    @new_grade.save
    assert_equal 3.5, @studentSubject.average_grades
  end
  it "Checking sum of grades - one grade" do
    assert_equal 5, @studentSubject.sum_grades
  end
  it "Checking sum of grades - two grades" do
    @new_grade = Grade.new
    @new_grade[:grade] = 2
    @new_grade[:comment] = "Za projekt z ruby2"
    @new_grade[:date] = "08.01.2019"
    @new_grade[:StudentSubject_id] = @studentSubject[:id]
    @new_grade.save
    assert_equal 7, @studentSubject.sum_grades
  end
  it "Checking count of grades - one grade" do
    assert_equal 1, @studentSubject.count_grades
  end
  it "Checking count of grades - two grades" do
    @new_grade = Grade.new
    @new_grade[:grade] = 2
    @new_grade[:comment] = "Za projekt z ruby2"
    @new_grade[:date] = "08.01.2019"
    @new_grade[:StudentSubject_id] = @studentSubject[:id]
    @new_grade.save
    assert_equal 2, @studentSubject.count_grades
  end

end
describe "Checking StudentSubject Class validation" do

  before {
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

    @studentSubject = StudentSubject.new
    @studentSubject[:Student_id] = @test_student[:id]
    @studentSubject[:Subject_id] = @test_subject[:id]

  }


  it "Checking error when student_id is nil" do
    @studentSubject[:Student_id] = nil
    assert_raises (Sequel::ValidationFailed) {@studentSubject.save}
  end

  it "Checking error when student_id is not integer" do
    @studentSubject[:Student_id] = "test"
    assert_raises (Sequel::ValidationFailed) {@studentSubject.save}
  end

  it "Checking error when student_id is negative integer" do
    @studentSubject[:Student_id] = -1
    assert_raises (Sequel::ValidationFailed) {@studentSubject.save}
  end


  it "Checking error when subject_id is nil" do
    @studentSubject[:Subject_id] = nil
    assert_raises (Sequel::ValidationFailed) {@studentSubject.save}
  end

  it "Checking error when subject_id is not integer" do
    @studentSubject[:Subject_id] = "test"
    assert_raises (Sequel::ValidationFailed) {@studentSubject.save}
  end

  it "Checking error when subject_id is negative integer" do
    @studentSubject[:Subject_id] = -1
    assert_raises (Sequel::ValidationFailed) {@studentSubject.save}
  end

  it "Checking error when subject_id and student_id is not unique pair" do
    @studentSubject_test = StudentSubject.new
    @studentSubject_test[:Student_id] = @test_student[:id]
    @studentSubject_test[:Subject_id] = @test_subject[:id]
    @studentSubject_test.save
    assert_raises (Sequel::ValidationFailed) {@studentSubject.save}
  end

  after {
    @studentSubject = nil
    @test_teacher = nil
    @test_student = nil
    @test_subject = nil
  }

end
