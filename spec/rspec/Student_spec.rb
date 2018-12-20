require_relative '../../lib/Register.rb'

describe "Checking Student class initialization" do
    before{
      @new_student = Student.new
    }

    it "Returns not nil while created" do
      expect(@new_student).not_to be nil
    end

    it "Returns instance of Student while created" do
      expect(@new_student).to be_instance_of(Student)
    end

    it "Student is a subclass of Sequel::Model" do
      expect(@new_student).to be_a(Sequel::Model)
    end

    after{
      @new_student = nil
    }
end

describe "Checking Student class functionality" do
  before{
    Database.init
    @new_student = Student.new
    @pre_add_len = Student.dataset.count
    @new_student[:name] = "Jan"
    @new_student[:surname] = "Kowalski"
    @new_student.save
    @post_add_len = Student.dataset.count
  }

  it "Inserting value should increase dataset length" do
    expect(@post_add_len).to eq(@pre_add_len+1)
  end

  it "Checking if value is inserted correctly" do
    expect(Student.last).to eq(@new_student)
  end

  it "Updating value shouldn't increase dataset length" do
    @updated_student = Student.last
    @updated_student[:surname] = "New-Surname"
    @updated_student.save
    expect(Student.dataset.count).to eq(@post_add_len)
  end

  it "Checking if value is updated correctly" do
    @updated_student = Student.last
    @updated_student[:surname] = "New-Surname"
    @updated_student.save
    expect(Student.last).to eq(@updated_student)
  end

  it "Deleting value should decrease dataset length" do
    # skip("no mocks implemented")
    @removed_student = Student.last
    @removed_student.delete
    expect(Student.dataset.count).to eq(@post_add_len-1)
  end

  it "Checking if value is removed correctly" do
    # skip("no mocks implemented")
    @removed_student = Student.last
    @removed_student.delete
    expect(Student.last).not_to eq(@removed_student)
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

    expect(Note.last).not_to be(@note)
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

    expect(StudentSubject.last).not_to be(@studentSubject)
  end

  it "Checking print function" do
    expect{@new_student.printline(1)}.to output(/2[ |]+Jan[ |]+Kowalski$/).to_stdout
  end

  after{
    @new_student = nil
  }
end

describe "Checking Student class validation" do
  before{
    @new_student = Student.new
    @new_student[:name] = "Jan"
    @new_student[:surname] = "Kowalski"
  }

  it "Checking error when name is nil" do
    @new_student[:name] = nil
    expect{@new_student.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when name is too short" do
    @new_student[:name] = "a"
    expect{@new_student.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when name format is invalid" do
    @new_student[:name] = "D4wid"
    expect{@new_student.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when name is not string" do
    @new_student[:name] = 4
    expect{@new_student.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when surname is nil" do
    @new_student[:surname] = nil
    expect{@new_student.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when surname is too short" do
    @new_student[:surname] = "Ko"
    expect{@new_student.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when surname format is invalid" do
    @new_student[:surname] = "kOwAlSkI"
    expect{@new_student.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when surname is not string" do
    @new_student[:surname] = ["Kowalski"]
    expect{@new_student.save}.to raise_error(Sequel::ValidationFailed)
  end



  after{
    @new_student = nil
  }

end
