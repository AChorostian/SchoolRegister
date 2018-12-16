class StudentSubject

    attr_accessor :id, :student_id, :subject_id

    def initialize
        @id = 0
        @student_id = 0
        @subject_id = 0
    end

    def sethash(data)
        @id = data[:id]
        @student_id = data[:student_id]
        @subject_id  = data[:subject_id]
        self
    end

    def gethash
        data = Hash.new
        data[:id] = @id
        data[:student_id] = @student_id
        data[:subject_id] = @subject_id
        data
    end

end