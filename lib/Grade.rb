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
        data.each do |key, value|
          validate_field(key,value)
        end
      end
    end

    def validate_field(key,value)
      case key
      when :id
        raise ArgumentError, "Wrong type of id field!" unless value.is_a? Integer and value>=0
      when :grade
        raise ArgumentError, "Wrong type of grade field!" unless value.is_a? Integer and value>=1 and value<=6
      when :comment
        raise ArgumentError, "Wrong type of comment field!" unless value.is_a? String
      when :date
        raise ArgumentError, "Wrong type of date field!" unless value.is_a? String and value.match(/\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])/)
      when :studentsubject_id
        raise ArgumentError, "Wrong type of studentsubject_id field" unless value.is_a? Integer and value >=0
      else
        raise ArgumentError, "Wrong key provided, check your input!"
      end    end

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
