require_relative 'Student'
require_relative 'Subject'
require_relative 'Teacher'
require_relative 'Grade'
require_relative 'Note'
require_relative 'Database'
require_relative 'insert'

class Register
    def self.drawmenu
        puts "============DZENNIK============"
        puts "1. Uczniowie"
        puts "2. Przedmioty"
        puts "3. Nauczyciele"
        puts "4. Statystyki"
        puts ""
        puts "5. Wyjscie"
        puts ""
        print "podaj numer: "
        #n = gets
        #puts n
    end
end

Database.init
insertstudents

Register.drawmenu


puts Database.findbyid(Student,2).gethash

print "\n"

Database.findall(Student).each do |obj|
    puts obj.gethash.to_s
end
