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
    @new_teacher[:surname] = "Abacki"
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

  it "Associating teacher to subject and removing teacher should set teacher_id to nil" do
    @subject = Subject.new
    @subject[:name] = "Testing subjects"
    @subject[:Teacher_id] = @new_teacher[:id]
    @subject.save
    @new_teacher.delete
    expect(Subject.first).to be(nil)
  end

  after{
    @new_teacher = nil
  }
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
