require_relative '../../lib/Register.rb'

describe "Checking StudentSubject class initialization" do
  before{
    @studentSubject = StudentSubject.new
  }

  it "Returns not nil while created" do
    expect(@studentSubject).not_to be nil
  end

  it "Returns instance of Note while created" do
    expect(@studentSubject).to be_instance_of(StudentSubject)
  end

  it "Note is a subclass of Sequel::Model" do
    expect(@studentSubject).to be_a(Sequel::Model)
  end

  it "StudentSubject is associated with :StudentSubject table" do
    expect(StudentSubject.table_name).to eq(:StudentSubject)
  end

  after{
    @studentSubject = nil
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
    expect(StudentSubject.dataset.count).to eq(@pre_add_len+1)
  end

  it "Checking if value is inserted correctly" do
    expect(StudentSubject.last).to eq(@studentSubject)
  end

  it "Updating value shouldn't increase dataset length" do
    @updated_studentSubject = StudentSubject.last

    @test_update_student = Student.new
    @test_update_student[:name] = "Update"
    @test_update_student[:surname] = "Test-Student"
    @test_update_student.save

    @updated_studentSubject[:Student_id] = @test_update_student[:id]
    @updated_studentSubject.save
    expect(StudentSubject.dataset.count).to eq(@post_add_len)
  end

  it "Checking if value is updated correctly" do
    @updated_studentSubject = StudentSubject.last

    @test_update_student = Student.new
    @test_update_student[:name] = "Update"
    @test_update_student[:surname] = "Test-Student"
    @test_update_student.save

    @updated_studentSubject[:Student_id] = @test_update_student[:id]
    @updated_studentSubject.save
    expect(StudentSubject.last).to eq(@updated_studentSubject)
  end

  it "Deleting value should decrease dataset length" do
    # skip("no mocks implemented")
    @removed_studentSubject = StudentSubject.last
    @removed_studentSubject.delete
    expect(StudentSubject.dataset.count).to eq(@post_add_len-1)
  end

  it "Checking if value is removed correctly" do
    # skip("no mocks implemented")
    @removed_studentSubject = StudentSubject.last
    @removed_studentSubject.delete
    expect(StudentSubject.last).not_to eq(@removed_studentSubject)
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

    expect(Grade.last).not_to be(@grade)
  end

  it "Checking print function" do
    expect{@studentSubject.printline(1)}.to output(/2[ |]+Testing subject[ |]+Test[ |]+Teacher$/).to_stdout
  end

  it "Checking print label function" do
    expect{StudentSubject.printlabels}.to output.to_stdout
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

  before(:each) do
    Database.init
    @studentSubject = StudentSubject.new
  end

  it "Assigning id of non existing Student" do
    @studentSubject[:Student_id] = 1
    expect{@studentSubject.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Assigning id of non existing Subject" do
    @studentSubject[:Subject_id] = 1
    expect{@studentSubject.save}.to raise_error(Sequel::ValidationFailed)
  end

  after(:each) do
    @studentSubject = nil
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
    expect{@studentSubject.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when student_id is not integer" do
    @studentSubject[:Student_id] = "test"
    expect{@studentSubject.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when student_id is negative integer" do
    @studentSubject[:Student_id] = -1
    expect{@studentSubject.save}.to raise_error(Sequel::ValidationFailed)
  end


  it "Checking error when subject_id is nil" do
    @studentSubject[:Subject_id] = nil
    expect{@studentSubject.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when subject_id is not integer" do
    @studentSubject[:Subject_id] = "test"
    expect{@studentSubject.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when subject_id is negative integer" do
    @studentSubject[:Subject_id] = -1
    expect{@studentSubject.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when subject_id and student_id is not unique pair" do
    @studentSubject_test = StudentSubject.new
    @studentSubject_test[:Student_id] = @test_student[:id]
    @studentSubject_test[:Subject_id] = @test_subject[:id]
    @studentSubject_test.save
    expect{@studentSubject.save}.to raise_error(Sequel::ValidationFailed)
  end

  after {
    @studentSubject = nil
    @test_teacher = nil
    @test_student = nil
    @test_subject = nil
  }

  end
