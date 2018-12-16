class Grade

    attr_reader :id, :grade, :category, :date, :studentsubject_id , :subject_id

    def initialize
        @id = 0
        @grade = 0
        @category = ""
        @date = 0
        @studentsubject_id = 0
    end

    def sethash(data)
        @id = data[:id]
        @grade = data[:grade]
        @category = data[:category]
        @date  = data[:date]
        @studentsubject_id  = data[:studentsubject_id]
        self
    end

    def gethash
        data = Hash.new
        data[:id] =  @id
        data[:grade] = @grade
        data[:category] = @category
        data[:date] = @date
        data[:studentsubject_id] = @studentsubject_id
        data
    end

end


