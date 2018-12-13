class Grade

    attr_reader :id, :grade, :category, :date, :student_id , :subject_id

    def initialize
        @id = 0
        @grade = 0
        @category = ""
        @date = 0

        @student_id = 0
        @subject_id = 0
    end

end


