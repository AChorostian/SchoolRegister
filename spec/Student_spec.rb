require_relative '../lib/Register.rb'

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
    @new_student[:surname] = "Abacki"
    @new_student.save
    @post_add_len = Student.dataset.count
  }

  it "Inserting value should increase dataset length" do
    expect(Student.dataset.count).to eq(@post_add_len+1)
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

  after{
    @new_student = nil
  }
end

describe "Checking Student class validation" do
  before{
    @new_student = Student.new
  }

  it "lol" do
    @new_student[:name] = nil
    @new_student[:surname] = "binus"
    expect{@new_student.save}.to raise_error(Sequel::ValidationFailed)
  end

  after{
    @new_student = nil
  }

end
