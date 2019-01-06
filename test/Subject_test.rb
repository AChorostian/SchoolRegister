require 'test_helper'

describe "Checking Subject class initialization" do
  before{
    @new_subject = Subject.new
  }

  it "Returns not nil while created" do
    refute_nil @new_subject
  end

  it "Returns instance of Subject while created" do
    assert_instance_of Subject, @new_subject
  end

  it "Subject is a subclass of Sequel::Model" do
    assert_kind_of(Sequel::Model,@new_subject)
  end
  it "Subject is associated with :Subject table" do
    assert_equal :Subject, Subject.table_name
  end
  after{
    @new_subject = nil
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

describe "Negative cases" do
  before{
    Database.init
    @subject = Subject.new
    @subject[:name] = "Testing subjects"
  }

  it "Assigning id of non existing teacher" do
    @subject[:Teacher_id] = 1
    assert_raises (Sequel::ValidationFailed) {@subject.save}
  end

  after{
    @subject = nil
  }
end

describe "Subject - statistics (with db loaded)" do
  before(:all) do
    Database.init
    Register.init
    @subject = Subject.first
  end
  it "Count Students test" do
    assert_equal 12, @subject.count_students
  end

  it "Count Grades test" do
    assert_equal 127, @subject.count_grades
  end

  it "Sum Grades test" do
    assert_equal 442, @subject.sum_grades
  end

  it "Overall Average Grades test" do
    assert_equal 3.4748176795970913, @subject.average_average_grades
  end

  it "Average Grades test" do
    assert_equal 3.4803149606299213, @subject.average_grades
  end

  it "Average Count Grades test" do
    assert_equal 10.583333333333334, @subject.average_count_grades
  end
  it "Max average grades test - object checking" do
    assert_instance_of StudentSubject, @subject.max_average_grades
  end
  it "Min average grades test - object checking" do
    assert_instance_of StudentSubject, @subject.min_average_grades
  end
  it "Max count grades test - object checking" do
    assert_instance_of StudentSubject, @subject.max_count_grades
  end
  it "Min count grades test - object checking" do
    assert_instance_of StudentSubject, @subject.min_count_grades
  end
  it "Max average grades test - value checking" do
    assert_equal 4.125, @subject.max_average_grades.average_grades
  end
  it "Min average grades test - value checking" do
    assert_equal 2.8, @subject.min_average_grades.average_grades
  end
  it "Max count grades test - value checking" do
    assert_equal 17, @subject.max_count_grades.count_grades
  end
  it "Min count grades test - value checking" do
    assert_equal 6, @subject.min_count_grades.count_grades
  end

end
describe "Subject - statistics (no db loaded)" do
  before(:all) do
    @subject = Subject.new
  end
  it "Count Students test" do
    assert_equal 0, @subject.count_students
  end

  it "Count Grades test" do
    assert_equal 0, @subject.count_grades
  end

  it "Sum Grades test" do
    assert_equal 0, @subject.sum_grades
  end

  it "Overall Average Grades test" do
    assert_equal 0, @subject.average_average_grades
  end

  it "Average Grades test" do
    assert_equal 0, @subject.average_grades
  end

  it "Average Count Grades test" do
    assert_equal 0, @subject.average_count_grades
  end
  it "Max average grades test" do
    assert_nil @subject.max_average_grades
  end
  it "Min average grades test" do
    assert_nil @subject.min_average_grades
  end
  it "Max count grades test" do
    assert_nil @subject.max_count_grades
  end
  it "Min count grades test" do
    assert_nil @subject.min_count_grades
  end
end

describe "Checking Subject class validation" do

  before {
    Database.init
    @test_teacher = Teacher.new
    @test_teacher[:name] = "Test"
    @test_teacher[:surname] = "Teacher"
    @test_teacher.save

    @subject = Subject.new
    @subject[:Teacher_id] = @test_teacher[:id]
    @subject[:name] = "Test"
  }

  it "Checking error when name is nil" do
    @subject[:name] = nil
    assert_raises (Sequel::ValidationFailed) {@subject.save}
  end

  it "Checking error when name is too short" do
    @subject[:name] = "T"
    assert_raises (Sequel::ValidationFailed) {@subject.save}
  end

  it "Checking error when name is too long" do
    @subject[:name] = "Test too long too long too long too long too long too long too long too long"
    assert_raises (Sequel::ValidationFailed) {@subject.save}
  end

  it "Checking error when name is not String" do
    @subject[:name] = [:name => "Test"]
    assert_raises (Sequel::ValidationFailed) {@subject.save}
  end

  it "Checking error when name is in invalid format" do
    @subject[:name] = "TEsting SUBJECT"
    assert_raises (Sequel::ValidationFailed) {@subject.save}
  end

  it "Checking error when teacher_id is nil" do
    @subject[:Teacher_id] = nil
    assert_raises (Sequel::ValidationFailed) {@subject.save}
  end

  it "Checking error when teacher_id is not integer" do
    @subject[:Teacher_id] = "Test"
    assert_raises (Sequel::ValidationFailed) {@subject.save}
  end

  it "Checking error when teacher_id is negative integer" do
    @subject[:Teacher_id] = -1
    assert_raises (Sequel::ValidationFailed) {@subject.save}
  end

  after {

    @subject = nil
    @test_teacher = nil
  }

end