class StudentSubject < Sequel::Model(Database.db[:StudentSubject])

    one_to_many :Grade
    many_to_one :Student
    many_to_one :Subject

    def self.printlabels
        puts " Nr |        Nazwa |             Nauczyciel "
        puts "----+--------------+------------------------"
    end

    def printline(nr)
        self.Subject.printline(nr)
    end

end