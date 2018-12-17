require 'sequel'
class Grade < Sequel::Model(Database.db[:Grade])

    many_to_one :StudentSubject

    def self.printlabels
      puts " Nr | Ocena |       Komentarz |       Data "
      puts "----+-------+-----------------+------------"
    end

    def printline(nr)
      printf("%3d |%6s |%16s |%11s\n" , nr , @grade.to_s , @comment.to_s , @date.to_s)
    end

end
