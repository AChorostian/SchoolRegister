require_relative '../lib/Register.rb'


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
    @new_teacher[:name] = "Jan"
    @new_teacher[:surname] = "Abacki"
    @new_teacher.save
    @curr_len = Teacher.dataset.count
  }

  it "Inserting value should increase dataset length" do
    expect(Teacher.dataset.count).to eq(@curr_len+1)
  end

  it "Checking if value is inserted correctly" do
    expect(Teacher.last).to eq(@new_teacher)
  end

  it "Updating value shouldn't increase dataset length" do
    @updated_teacher = @new_teacher
    @updated_teacher[:surname] = "New-Surname"
    @updated_teacher.save
    expect(Teacher.dataset.count).to eq(@curr_len)
  end

  it "Checking if value is updated correctly" do
    @updated_teacher = Teacher.last
    @updated_teacher[:surname] = "New-Surname"
    @updated_teacher.save
    expect(Teacher.last).to eq(@updated_teacher)
  end

  it "Deleting value should decrease dataset length" do
    skip("no mocks implemented")
    @removed_teacher = Teacher.last
    @removed_teacher.delete
    expect(Teacher.dataset.count).to eq(@curr_len-1)
  end

  it "Checking if value is removed correctly" do
    skip("no mocks implemented")
    @removed_teacher = Teacher.last
    @removed_teacher.delete
    expect(Teacher.last).not_to eq(@removed_teacher)
  end

  after{
    @new_teacher = nil
  }
end

describe "Checking Teacher class validation" do
  before{
    @new_teacher = Teacher.new
  }

  it "lol" do
    @new_teacher[:name] = nil
    @new_teacher[:surname] = "surname"
    expect{@new_teacher.save}.to raise_error(Sequel::ValidationFailed)
  end

  after{
    @new_teacher = nil
  }
end
