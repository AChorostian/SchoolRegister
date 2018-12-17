require 'sequel'
require_relative 'Database'
require_relative 'Student'
require_relative 'Subject'
require_relative 'Teacher'
require_relative 'Grade'
require_relative 'Note'
require_relative 'StudentSubject'
require_relative 'CsvManager'
# require_relative 'Menu'


class Register

    def initialize
        #lolz = Sequel.sqlite ( "database.db")
        CsvManager.importFromCsv("data/students.csv", Student )
        CsvManager.importFromCsv("data/teachers.csv", Teacher )
        CsvManager.importFromCsv("data/subjects.csv", Subject )
        CsvManager.importFromCsv("data/notes.csv", Note )
        CsvManager.importFromCsv("data/studentsubjects.csv", StudentSubject )
        CsvManager.importFromCsv("data/grades.csv", Grade )
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
