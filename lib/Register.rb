require_relative 'Student'
require_relative 'Subject'
require_relative 'Teacher'
require_relative 'Grade'
require_relative 'Note'
require_relative 'Database'
require_relative 'CsvManager'

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
        #print "podaj numer: "
        #n = gets
        #puts n
    end
end

Database.init
CsvManager.importFromCsv("data/students.csv",Student )
CsvManager.importFromCsv("data/teachers.csv",Teacher )
Register.drawmenu

#CsvManager.saveToFile("students.csv", Database.findall(Student))
#CsvManager.saveToFile("teachers.csv", Database.findall(Teacher))


puts "Students"
puts Database.findall(Student)

puts "Teachers"
puts Database.findall(Teacher)

