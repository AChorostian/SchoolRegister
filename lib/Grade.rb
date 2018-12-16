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

    def sethash(data)
        @id = data[:id]
        @grade = data[:grade]
        @category = data[:category]
        @date  = data[:date]
        @student_id  = data[:student_id]
        @teacher_id  = data[:teacher_id]
        self
    end

    def gethash
        data = Hash.new
        data[:id] =  @id
        data[:grade] = @grade
        data[:category] = @category
        data[:date] = @date
        data[:student_id] = @student_id
        data[:teacher_id] = @teacher_id
        data
    end

end


