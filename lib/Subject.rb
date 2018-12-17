class Subject < Sequel::Model(Database.db[:Subject])

    many_to_one :Teacher
    one_to_many :StudentSubject

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


