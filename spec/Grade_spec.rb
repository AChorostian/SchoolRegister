require_relative '../lib/Register.rb'

describe "Checking class initialization" do

  before{
    @grade = Grade.new
  }

  it "Returns not nil while created" do
    expect(@grade).not_to be nil
  end

  it "Returns instance of Grade while created" do
    expect(@grade).to be_instance_of(Grade)
  end

  after{
    @grade = nil
    @data = nil
  }

end

describe "Checking class correctness" do
  before{
    @grade = Grade.new
  }
    it "test" do
      expect(true).to eq(true)
    end


  after{ @grade = nil
  }


end
