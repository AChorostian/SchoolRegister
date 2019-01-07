require 'sequel'
require_relative 'Database'
require_relative 'Student'
require_relative 'Subject'
require_relative 'Teacher'
require_relative 'Grade'
require_relative 'Note'
require_relative 'StudentSubject'
require_relative 'CsvManager'
require_relative 'Menu'

class Register

    def self.init
        CsvManager.importFromCsv("data/students.csv", Student )
        CsvManager.importFromCsv("data/teachers.csv", Teacher )
        CsvManager.importFromCsv("data/subjects.csv", Subject )
        CsvManager.importFromCsv("data/notes.csv", Note )
        CsvManager.importFromCsv("data/studentsubjects.csv", StudentSubject )
        CsvManager.importFromCsv("data/grades.csv", Grade )
    end

    def run
        Register.init
        Menu.main while true
    end

    def self.export
        CsvManager.saveToFile("students1.csv", Database.db[:Student] )
        CsvManager.saveToFile("teachers1.csv", Database.db[:Teacher] )
        CsvManager.saveToFile("subjects.csv", Database.db[:Subject] )
        CsvManager.saveToFile("notes.csv", Database.db[:Note] )
        CsvManager.saveToFile("studentsubjects.csv", Database.db[:StudentSubject] )
        CsvManager.saveToFile("grades.csv", Database.db[:Grade] )
    end

end