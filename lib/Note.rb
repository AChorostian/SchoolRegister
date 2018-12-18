require 'sequel'
class Note < Sequel::Model(Database.db[:Note])

    plugin :validation_helpers
    many_to_one :Teacher
    many_to_one :Student

    def validate
        super
        validates_presence [:desciption,:date,:Student_id,:Teacher_id], message: 'was not given'
        validates_type String [:desciption,:date], message: 'wrong value type'
        validates_type Integer [:Teacher_id,:Student_id], message: 'wrong value type'
        validates_length_range 3..500, :desciption, message: lambda{|s| "should be more than #{s} characters"}

        errors.add(:Teacher_id, 'Teacher_id value is lower than 0') if teacher_id <= 0

    end

    def self.printlabels
        puts " Nr |       Data |            Nauczyciel | Opis"
        puts "----+------------+-----------------------|--------"
    end

    def printline(nr)
        teacher_string = self.Teacher.name + " " + self.Teacher.surname
        printf("%3d |%11s |%22s | %s\n" , nr+1 , date.to_s , teacher_string , description.to_s )
    end

end


