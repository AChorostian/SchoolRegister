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
                @@db.execute "INSERT INTO Student(name,surname)
                              VALUES ('"+obj.name+"','"+obj.surname+"')"
            when Grade
                @@db.execute "INSERT INTO Grade(grade,category,date,subject_id,student_id)
                              VALUES ('"+obj.grade.to_s+"','"+obj.category+"','"+obj.date.to_s+"',
                                      '"+obj.subject_id.to_s+"','"+obj.student_id.to_s+"')"
            when Subject
                @@db.execute "INSERT INTO Subject(name,teacher_id)
                              VALUES ('"+obj.name+"','"+obj.teacher_id.to_s+"')"
            when Note
                @@db.execute "INSERT INTO Note(description,date,student_id,teacher_id)
                              VALUES ('"+obj.description+"','"+obj.date.to_s+"',
                                      '"+obj.student_id.to_s+"','"+obj.teacher_id.to_s+"')"
            when Teacher
                @@db.execute "INSERT INTO Teacher(name,surname)
                              VALUES ('"+obj.name+"','"+obj.surname+"')"
            #when StudentSubject
            #    @@db.execute "INSERT INTO StudentSubject(student_id,subject_id)
            #                  VALUES ('"+obj.student_id+"','"+obj.subject_id+"')"
            else
                raise ArgumentError
        end
    end
    def self.update obj
        case obj
        when Student
            @@db.execute "UPDATE Student SET name = '"+obj.name+"' ,
                                             surname = '"+obj.surname+"'
                          WHERE id = "+obj.id.to_s
        when Grade
            @@db.execute "UPDATE Grade SET grade = '"+obj.grade.to_s+"' ,
                                           category = '"+obj.category+"' ,
                                           date = '"+obj.date.to_s+"' ,
                                           subject_id = '"+obj.subject_id.to_s+"' ,
                                           student_id = '"+obj.student_id.to_s+"'
                          WHERE id = "+obj.id.to_s
        when Subject
            @@db.execute "UPDATE Subject SET name = '"+obj.name+"' ,
                                             teacher_id = '"+obj.teacher_id.to_s+"'
                          WHERE id = "+obj.id.to_s
        when Note
            @@db.execute "UPDATE Note SET description = '"+obj.description+"' ,
                                          date = '"+obj.date.to_s+"' ,
                                          student_id = '"+obj.student_id.to_s+"' ,
                                          teacher_id = '"+obj.teacher_id.to_s+"'
                          WHERE id = "+obj.id.to_s
        when Teacher
            @@db.execute "UPDATE Teacher SET name = '"+obj.name+"' ,
                                             surname = '"+obj.surname+"'
                          WHERE id = "+obj.id.to_s
        else
            raise ArgumentError
        end
    end


end



