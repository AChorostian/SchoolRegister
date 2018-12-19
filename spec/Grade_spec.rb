require_relative '../lib/Register.rb'

describe "Checking Grade class initialization" do

  before{
    @grade = Grade.new
  }

  it "Returns not nil while created" do
    expect(@grade).not_to be nil
  end

  it "Returns instance of Grade while created" do
    expect(@grade).to be_instance_of(Grade)
  end

  it "Grade is a subclass of Sequel::Model" do
    expect(@grade).to be_a(Sequel::Model)
  end

  after{
    @grade = nil
  }

end

describe "Checking Grade class functionality" do
  before{
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
    expect(Grade.dataset.count).to eq(@pre_add_len+1)
  end

  it "Checking if value is inserted correctly" do
    expect(Grade.last).to eq(@grade)
  end

  it "Updating value shouldn't increase dataset length" do
    @updated_grade= Grade.last
    @updated_grade[:grade] = 6
    @updated_grade.save
    expect(Grade.dataset.count).to eq(@post_add_len)
  end

  it "Checking if value is updated correctly" do
    @updated_grade = Grade.last
    @updated_grade[:grade] = 6
    @updated_grade.save
    expect(Grade.last).to eq(@updated_grade)
  end

  it "Deleting value should decrease dataset length" do
    # skip("no mocks implemented")
    @removed_grade = Grade.last
    @removed_grade.delete
    expect(Grade.dataset.count).to eq(@post_add_len-1)
  end

  it "Checking if value is removed correctly" do
    # skip("no mocks implemented")
    @removed_grade = Grade.last
    @removed_grade.delete
    expect(Grade.last).not_to eq(@removed_grade)
  end

  after{
    @test_teacher = nil
    @test_subject = nil
    @test_student = nil
    @grade = nil
    @test_studentSubject = nil
  }



end


describe "Checking Grade class functionality" do
  before{
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
    expect{@grade.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when grade is not integer" do
    @grade[:grade] = "Dwója"
    expect{@grade.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when grade is not between 1 and 6" do
    @grade[:grade] = 7
    expect{@grade.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when comment is nil" do
    @grade[:comment] = nil
    expect{@grade.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when comment is not string" do
    @grade[:comment] = ["Praca", "Praca"]
    expect{@grade.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when comment is too short" do
    @grade[:comment] = "T"
    expect{@grade.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when date is nil" do
    @grade[:date] = nil
    expect{@grade.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when date has invalid format" do
    @grade[:date] = "2019.01.01"
    expect{@grade.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when date is not string" do
    @grade[:date] = 17
    expect{@grade.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when studentSubject_id is nil" do
    @grade[:StudentSubject_id] = nil
    expect{@grade.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when studentSubject_id is not integer" do
    @grade[:StudentSubject_id] = "test"
    expect{@grade.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when studentSubject_id is negative integer" do
    @grade[:StudentSubject_id] = -1
    expect{@grade.save}.to raise_error(Sequel::ValidationFailed)
  end


  after{
    @test_teacher = nil
    @test_subject = nil
    @test_student = nil
    @grade = nil
    @test_studentSubject = nil
  }


  end
