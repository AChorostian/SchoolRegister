require_relative '../../lib/Register.rb'

describe "Checking Teacher class initialization" do
  before{
    @teacher = Teacher.new
  }

  it "Returns not nil while created" do
    expect(@teacher).not_to be nil
  end

  it "Returns instance of Teacher while created" do
    expect(@teacher).to be_instance_of(Teacher)
  end

  it "Teacher is a subclass of Sequel::Model" do
    expect(@teacher).to be_a(Sequel::Model)
  end

  it "Teacher is associated with :Teacher table" do
    expect(Teacher.table_name).to eq(:Teacher)
  end

  after{
    @teacher = nil
  }

end

describe "Checking Teacher class functionality" do
  before{
    Database.init
    @new_teacher = Teacher.new
    @pre_add_len = Teacher.dataset.count
    @new_teacher[:name] = "Jan"
    @new_teacher[:surname] = "Kowalski"
    @new_teacher.save
    @post_add_len = Teacher.dataset.count
  }

  it "Inserting value should increase dataset length" do
    expect(Teacher.dataset.count).to eq(@pre_add_len+1)
  end

  it "Checking if value is inserted correctly" do
    expect(Teacher.last).to eq(@new_teacher)
  end

  it "Updating value shouldn't increase dataset length" do
    @updated_teacher = Teacher.last
    @updated_teacher[:surname] = "New-Surname"
    @updated_teacher.save
    expect(Teacher.dataset.count).to eq(@post_add_len)
  end

  it "Checking if value is updated correctly" do
    @updated_teacher = Teacher.last
    @updated_teacher[:surname] = "New-Surname"
    @updated_teacher.save
    expect(Teacher.last).to eq(@updated_teacher)
  end

  it "Deleting value should decrease dataset length" do
    # skip("no mocks implemented")
    @removed_teacher = Teacher.last
    @removed_teacher.delete
    expect(Teacher.dataset.count).to eq(@post_add_len-1)
  end

  it "Checking if value is removed correctly" do
    # skip("no mocks implemented")
    @removed_teacher = Teacher.last
    @removed_teacher.delete
    expect(Teacher.last).not_to eq(@removed_teacher)
  end

  it "Associating teacher to subject and removing teacher should remove subject" do
    @removed_teacher = Teacher.last

    @subject = Subject.new
    @subject[:name] = "Testing subjects"
    @subject[:Teacher_id] = @removed_teacher[:id]
    @subject.save

    @removed_teacher.delete

    expect(Subject.last).not_to be(@subject)
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
    expect(Note.last).not_to be(@note)

  end

  it "Checking print function" do
    expect{@new_teacher.printline(1)}.to output(/2[ |]+Jan[ |]+Kowalski$/).to_stdout
  end

  it "Checking print label function" do
    expect{Teacher.printlabels}.to output.to_stdout
  end

  after{
    @new_teacher = nil
  }
end
describe "Teacher - statistics (with db loaded)" do
  before(:all) do
    Database.init
    Register.init
    @teacher = Teacher.first
  end
  it "Count Subjects test" do
    expect(@teacher.count_subjects).to eq(2)
  end

  it "Count Grades test" do
    expect(@teacher.count_grades).to eq(251)
  end

  it "Count Notes test" do
    expect(@teacher.count_notes).to eq(10)
  end

  it "Overall Average Grades test" do
    expect(@teacher.average_average_subjects).to eq(3.5605714285714285)
  end

  it "Average Grades test" do
    expect(@teacher.average_grades).to eq(3.5617529880478087)
  end
end
describe "Teacher - statistics (no db loaded)" do
  before(:all) do
    @teacher = Teacher.new
  end
  it "Count Subjects test" do
    expect(@teacher.count_subjects).to eq(0)
  end

  it "Count Grades test" do
    expect(@teacher.count_grades).to eq(0)
  end

  it "Count Notes test" do
    expect(@teacher.count_notes).to eq(0)
  end

  it "Overall Average Grades test" do
    expect(@teacher.average_average_subjects).to eq(0)
  end

  it "Average Grades test" do
    expect(@teacher.average_grades).to eq(0)
  end
end
describe "Checking Teacher class validation" do
  before{
    @new_teacher = Teacher.new
    @new_teacher[:name] = "Jan"
    @new_teacher[:surname] = "Kowalski"
  }

  it "Checking error when name is nil" do
    @new_teacher[:name] = nil
    expect{@new_teacher.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when name is too short" do
    @new_teacher[:name] = "D"
    expect{@new_teacher.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when name is too long" do
    @new_teacher[:name] = "Testlongnamenamenamenamenamenamenamenamenamenamenamenamenamenamenamename"
    expect{@new_teacher.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when name format is invalid" do
    @new_teacher[:name] = "D4wid"
    expect{@new_teacher.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when name is not string" do
    @new_teacher[:name] = 4
    expect{@new_teacher.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when surname is nil" do
    @new_teacher[:surname] = nil
    expect{@new_teacher.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when surname is too short" do
    @new_teacher[:surname] = "Ko"
    expect{@new_teacher.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when surname is too long" do
    @new_teacher[:surname] = "Testlongnamenamenamenamenamenamenamenamenamenamenamenamenamenamenamename"
    expect{@new_teacher.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when surname format is invalid" do
    @new_teacher[:surname] = "kOwAlSkI"
    expect{@new_teacher.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when surname is not string" do
    @new_teacher[:surname] = ["Kowalski"]
    expect{@new_teacher.save}.to raise_error(Sequel::ValidationFailed)
  end


  after{
    @new_teacher = nil
  }

end
