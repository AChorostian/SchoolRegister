require_relative 'Student'
require_relative 'Subject'
require_relative 'Teacher'
require_relative 'Grade'
require_relative 'Note'
require_relative 'Database'
require_relative 'insert'
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
        print "podaj numer: "
        #n = gets
        #puts n
    end
end

Database.init
CsvManager.importFromCsv("data/students.csv",Student )
Register.drawmenu

CsvManager.saveToFile("students", Database.findall(Student))

Database.findall(Student).each do |row|
  puts row
end

