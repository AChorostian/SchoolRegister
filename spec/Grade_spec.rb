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

describe "Checking Grade class correctness" do
  before{
    @grade = Grade.new
  }
    it "test" do
      expect(true).to eq(true)
    end


  after{ @grade = nil
  }


end
