class Subject

    attr_reader :id, :name, :teacher_id

    def initialize
        @id = 0
        @name = ""
        @teacher_id = 0
    end

    def sethash(data)
        @id = data[:id]
        @name = data[:name]
        @teacher_id  = data[:teacher_id]
        self
    end

    def gethash
        data = Hash.new
        data[:id] = @id
        data[:name] = @name
        data[:teacher_id] = @teacher_id
        data
    end

    def self.printlabels
        puts " Nr |        Nazwa |             Nauczyciel "
        puts "----+--------------+------------------------"
    end

    def printline(nr)
        teacher = Database.findbyid(Teacher,@teacher_id)
        ts = teacher.name + " " + teacher.surname
        printf("%3d |%13s |%23s\n" , nr , @name , ts )
    end

end


