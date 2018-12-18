class Subject < Sequel::Model(Database.db[:Subject])

    many_to_one :Teacher
    one_to_many :StudentSubject

    def validate
        super
    end

    def self.printlabels
        puts " Nr |        Nazwa |             Nauczyciel "
        puts "----+--------------+------------------------"
    end

    def printline(nr)
        printf("%3d |%13s |%23s\n" , nr+1 , name , self.Teacher.name + " " + self.Teacher.surname )
    end

end


