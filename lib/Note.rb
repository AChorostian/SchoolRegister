require 'sequel'
class Note < Sequel::Model(Database.db[:Note])

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


