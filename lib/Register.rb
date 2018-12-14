require_relative 'Student'
require_relative 'Database'

class Register
    def self.drawmenu
        puts "xd"
        puts "xd"
    end
end



Register.drawmenu


Database.init
Database.db.execute "DELETE FROM Student"

Database.add Student.new("jan" , "kowalski" )
Database.add Student.new("ktos" , "ktosiowski" )

s = Student.new("ktos" , "ktosiowskowaty" )
s.setid(1)

Database.update s

s.setid(2)

Database.delete s


Database.findbyid( Student , 1 )



