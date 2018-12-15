class Note

    attr_reader :id, :description, :date, :student_id, :teacher_id

    def initialize
        @id = 0
        @description = ""
        @date = 0
        @student_id = 0
        @teacher_id = 0
    end

    def sethash(data)
        @id = data[:id]
        @description = data[:description]
        @date  = data[:date]
        @student_id  = data[:student_id]
        @teacher_id  = data[:teacher_id]
        self
    end

    def gethash
        data = Hash.new
        data[:id] =  @id
        data[:description] = @description
        data[:date] = @date
        data[:student_id] = @student_id
        data[:teacher_id] = @teacher_id
        data
    end

end


