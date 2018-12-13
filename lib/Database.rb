require 'sqlite3'

# NOTES
#
# sqlite available types: BLOB, TEXT, INTEGER, REAL, NUMERIC

class Database
    attr_reader :db

    @@db = SQLite3::Database.open "database.db"

    def self.init
        @@db.execute "CREATE TABLE IF NOT EXISTS Student(
            id INTEGER PRIMARY KEY,
            name TEXT,
            surname TEXT)"
        @@db.execute "CREATE TABLE IF NOT EXISTS Grade(
            id INTEGER PRIMARY KEY,
            grade INTEGER,
            category TEXT,
            date TEXT,
            subject_id INTEGER,
            student_id INTEGER)"
        @@db.execute "CREATE TABLE IF NOT EXISTS Subject(
            id INTEGER PRIMARY KEY,
            name TEXT,
            teacher_id INTEGER)"
        @@db.execute "CREATE TABLE IF NOT EXISTS Note(
            id INTEGER PRIMARY KEY,
            description TEXT,
            date TEXT,
            student_id INTEGER,
            teacher_id INTEGER)"
        @@db.execute "CREATE TABLE IF NOT EXISTS Teacher(
            id INTEGER PRIMARY KEY,
            name TEXT,
            surname TEXT)"
        @@db.execute "CREATE TABLE IF NOT EXISTS StudentSubject(
            student_id INTEGER,
            subject_id INTEGER)"
    end

    def self.db
        @@db
    end

    def self.add obj
        case obj
            when Student
                @@db.execute "INSERT INTO Student(name,surname) VALUES ('"+obj.name+"','"+obj.surname+"')"
            when Grade
                @@db.execute "INSERT INTO Grade(grade,category,date,subject_id,student_id) VALUES ('"+obj.grade+"','"+obj.category+"','"+obj.date+"','"+obj.subject_id+"','"+obj.student_id+"')"
            when Subject
                @@db.execute "INSERT INTO Subject(name,teacher_id) VALUES ('"+obj.name+"','"+obj.teacher+"')"
            when Note
                @@db.execute "INSERT INTO Note(description,date,student_id,teacher_id) VALUES ('"+obj.description+"','"+obj.date+"','"+obj.student_id+"','"+obj.teacher_id+"')"
            when Teacher
                @@db.execute "INSERT INTO Teacher(name,surname) VALUES ('"+obj.name+"','"+obj.surname+"')"
            #when StudentSubject
                #@@db.execute "INSERT INTO StudentSubject(student_id,subject_id) VALUES ('"+obj.student_id+"','"+obj.subject_id+"')"
            else
                raise ArgumentError
        end
    end
end



Database.init
Database.db.execute "DELETE FROM Student"

Database.add Student.new("jan" , "kowalski" )
Database.add Student.new("ktos" , "ktosiowski" )

puts Database.db.execute "SELECT * FROM Student"


