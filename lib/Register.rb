require 'sequel'
#require_relative 'Student'
#require_relative 'Subject'
#require_relative 'Teacher'
#require_relative 'Grade'
#require_relative 'Note'
#require_relative 'StudentSubject'
require_relative 'Database'
#require_relative 'CsvManager'
#require_relative 'Menu'


class Register

    def initialize
        Database.init

        duupa = Database.new
        #lolz = Sequel.sqlite ( "database.db")
        #Database.addArray CsvManager.importFromCsv("data/students.csv", Student )
        #Database.addArray CsvManager.importFromCsv("data/teachers.csv", Teacher )
        #Database.addArray CsvManager.importFromCsv("data/subjects.csv", Subject )
        #Database.addArray CsvManager.importFromCsv("data/notes.csv", Note )
        #Database.addArray CsvManager.importFromCsv("data/studentsubjects.csv", StudentSubject )
        #Database.addArray CsvManager.importFromCsv("data/grades.csv", Grade )
    end

    def load

    end

    def run
        #Menu.main
    end

    def exitandsave
        CsvManager.saveToFile("students.csv", Database.findall(Student))
        CsvManager.saveToFile("teachers.csv", Database.findall(Teacher))
        CsvManager.saveToFile("subjects.csv", Database.findall(Subject))
    end

end
