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

    def self.printlabels
        puts " Nr |       Data |            Nauczyciel | Opis"
        puts "----+------------+-----------------------|--------"
    end

    def printline(nr)
        teacher = Database.findbyid(Teacher,@teacher_id)
        teacher_string = teacher.name + " " + teacher.surname
        printf("%3d |%11s |%22s | %s\n" , nr , @date.to_s , teacher_string , @description.to_s )
    end

end


