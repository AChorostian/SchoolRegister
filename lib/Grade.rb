class Grade

    attr_reader :id, :grade, :comment, :date, :studentsubject_id , :subject_id

    def initialize
        @id = 0
        @grade = 0
        @comment = ""
        @date = 0
        @studentsubject_id = 0
    end

    def validate(data)
      raise ArgumentError, "Wrong type of argument provided!" unless data.is_a? Hash or data.is_a? String or data.is_a? Integer
      if data.is_a? Hash
        return nil
      end
    end

    def sethash(data)
        @id = data[:id]
        @grade = data[:grade]
        @comment = data[:comment]
        @date  = data[:date]
        @studentsubject_id  = data[:studentsubject_id]
        self
    end

    def gethash
        data = Hash.new
        data[:id] =  @id
        data[:grade] = @grade
        data[:comment] = @comment
        data[:date] = @date
        data[:studentsubject_id] = @studentsubject_id
        data
    end

end
