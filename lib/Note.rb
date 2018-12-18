require 'sequel'
class Note < Sequel::Model(Database.db[:Note])

    many_to_one :Teacher
    many_to_one :Student

    def self.printlabels
        puts " Nr |       Data |            Nauczyciel | Opis"
        puts "----+------------+-----------------------|--------"
    end

    def printline(nr)
        teacher_string = self.Teacher.name + " " + self.Teacher.surname
        printf("%3d |%11s |%22s | %s\n" , nr+1 , date.to_s , teacher_string , description.to_s )
    end

end


