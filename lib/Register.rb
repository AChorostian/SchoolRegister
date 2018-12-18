require 'sequel'
require_relative 'Database'
require_relative 'Student'
require_relative 'Subject'
require_relative 'Teacher'
require_relative 'Grade'
require_relative 'Note'
require_relative 'StudentSubject'
require_relative 'CsvManager'
require_relative 'Single'
require_relative 'List'
require_relative 'Menu'


class Register

    def self.testinit
        CsvManager.importFromCsv("data/students.csv", Student )
        CsvManager.importFromCsv("data/teachers.csv", Teacher )
        #CsvManager.importFromCsv("data/subjects.csv", Subject )
        #CsvManager.importFromCsv("data/notes.csv", Note )
        #CsvManager.importFromCsv("data/studentsubjects.csv", StudentSubject )
        #CsvManager.importFromCsv("data/grades.csv", Grade )
    end

    def self.init
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
        Register.init
        Menu.main
    end

    def exitandsave
        CsvManager.saveToFile("students.csv", Database.findall(Student))
        CsvManager.saveToFile("teachers.csv", Database.findall(Teacher))
        CsvManager.saveToFile("subjects.csv", Database.findall(Subject))
    end

end


class String
    def black;          "\e[30m#{self}\e[0m" end
    def red;            "\e[31m#{self}\e[0m" end
    def green;          "\e[32m#{self}\e[0m" end
    def brown;          "\e[33m#{self}\e[0m" end
    def blue;           "\e[34m#{self}\e[0m" end
    def magenta;        "\e[35m#{self}\e[0m" end
    def cyan;           "\e[36m#{self}\e[0m" end
    def gray;           "\e[37m#{self}\e[0m" end

    def bg_black;       "\e[40m#{self}\e[0m" end
    def bg_red;         "\e[41m#{self}\e[0m" end
    def bg_green;       "\e[42m#{self}\e[0m" end
    def bg_brown;       "\e[43m#{self}\e[0m" end
    def bg_blue;        "\e[44m#{self}\e[0m" end
    def bg_magenta;     "\e[45m#{self}\e[0m" end
    def bg_cyan;        "\e[46m#{self}\e[0m" end
    def bg_gray;        "\e[47m#{self}\e[0m" end

    def bold;           "\e[1m#{self}\e[22m" end
    def italic;         "\e[3m#{self}\e[23m" end
    def underline;      "\e[4m#{self}\e[24m" end
    def blink;          "\e[5m#{self}\e[25m" end
    def reverse_color;  "\e[7m#{self}\e[27m" end
end