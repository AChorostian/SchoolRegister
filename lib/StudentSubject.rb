class StudentSubject < Sequel::Model(Database.db[:StudentSubject])
    def self.printlabels
        puts " Nr |        Nazwa |             Nauczyciel "
        puts "----+--------------+------------------------"
    end

    def printline(nr)
        Database.findbyid(Subject,@subject_id).printline(nr)
    end

end