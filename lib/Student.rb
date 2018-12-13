class Student

    attr_reader :student_id, :name, :surname, :subjects

    def initialize
        @student_id = 0
        @name = ""
        @surname = ""
        @subjects = Array.new
    end

end


