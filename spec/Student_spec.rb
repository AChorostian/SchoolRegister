require_relative '../lib/Student.rb'

describe "Checking class initialization" do
    before{
      @student = Student.new
    }

    it "Returns not nil while created" do
      expect(@student).not_to be nil
    end

    it "Returns instance of Student while created" do
      expect(@student).to be_instance_of(Student)
    end

    after{
      @student = nil
    }

end
