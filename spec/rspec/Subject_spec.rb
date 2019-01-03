require_relative '../../lib/Register.rb'

describe "Checking Subject class initialization" do
  before{
    @subject = Subject.new
  }

  it "Returns not nil while created" do
    expect(@subject).not_to be nil
  end

  it "Returns instance of Subject while created" do
    expect(@subject).to be_instance_of(Subject)
  end

  it "Subject is a subclass of Sequel::Model" do
    expect(@subject).to be_a(Sequel::Model)
  end

  it "Subject is associated with :Subject table" do
    expect(Subject.table_name).to eq(:Subject)
  end

  after{
    @subject = nil

  }

end

describe "Checking Subject class functionality" do

  before(:each) do
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
    expect(Subject.dataset.count).to eq(@pre_add_len+1)
  end

  it "Checking if value is inserted correctly" do
    expect(Subject.last).to eq(@subject)
  end

  it "Updating value shouldn't increase dataset length" do
    @updated_subject = Subject.last
    @updated_subject[:name] = "Testing if subject is ok"
    @updated_subject.save
    expect(Subject.dataset.count).to eq(@post_add_len)
  end

  it "Checking if value is updated correctly" do
    @updated_subject = Subject.last
    @updated_subject[:name] = "Testing if subject is ok"
    @updated_subject.save
    expect(Subject.last).to eq(@updated_subject)
  end

  it "Deleting value should decrease dataset length" do
    # skip("no mocks implemented")
    @removed_subject = Subject.last
    @removed_subject.delete
    expect(Subject.dataset.count).to eq(@post_add_len-1)
  end

  it "Checking if value is removed correctly" do
    # skip("no mocks implemented")
    @removed_subject = Subject.last
    @removed_subject.delete
    expect(Subject.last).not_to eq(@removed_subject)
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

    expect(StudentSubject.last).not_to be(@studentSubject)
  end

  it "Checking print function" do
    expect{@subject.printline(1)}.to output(/2[ |]+Testing subjects[ |]+Test[ |]+Teacher$/).to_stdout
  end

  it "Checking print label function" do
    expect{Subject.printlabels}.to output.to_stdout
  end


  after(:each) do
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
    expect{@subject.save}.to raise_error{Sequel::ValidationFailed}
  end

  after{
    @subject = nil
  }
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
    expect{@subject.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when name is too short" do
    @subject[:name] = "T"
    expect{@subject.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when name is too long" do
    @subject[:name] = "Test too long too long too long too long too long too long too long too long"
    expect{@subject.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when name is not String" do
    @subject[:name] = [:name => "Test"]
    expect{@subject.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when name is in invalid format" do
    @subject[:name] = "TEsting SUBJECT"
    expect{@subject.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when teacher_id is nil" do
    @subject[:Teacher_id] = nil
    expect{@subject.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when teacher_id is not integer" do
    @subject[:Teacher_id] = "Test"
    expect{@subject.save}.to raise_error(Sequel::ValidationFailed)
  end

  it "Checking error when teacher_id is negative integer" do
    @subject[:Teacher_id] = -1
    expect{@subject.save}.to raise_error(Sequel::ValidationFailed)
  end

  after {

    @subject = nil
    @test_teacher = nil
  }

end
