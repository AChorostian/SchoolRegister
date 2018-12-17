class StudentSubject < Sequel::Model(Database.db[:StudentSubject])

    one_to_many :Grade
    many_to_one :Student
    many_to_one :Subject

    def self.printlabels
        puts " Nr |        Nazwa |             Nauczyciel "
        puts "----+--------------+------------------------"
    end

    def printline(nr)
        Database.findbyid(Subject,@subject_id).printline(nr)
    end

end