require 'sqlite3'

# NOTES
#
# sqlite available types: BLOB, TEXT, INTEGER, REAL, NUMERIC

class Database

    @@db = SQLite3::Database.open "database.db"

    def self.init
        @@db.execute "CREATE TABLE IF NOT EXISTS Student(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
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
        h = obj.gethash
        h.delete(:id)
        @@db.execute "INSERT INTO " + obj.class.to_s + "(" + h.keys.to_s.delete("[:]") + ")
                      VALUES (" + h.values.to_s.delete("[:]") + ")"
    end
    def self.update obj
        h = obj.gethash
        @@db.execute "Update " + obj.class.to_s + " SET (" + h.keys.to_s.delete("[:]") + ")
                      = (" + h.values.to_s.delete("[:]") + ") WHERE id = "+obj.id.to_s
    end

    def self.delete obj
        @@db.execute "DELETE FROM " + obj.class.to_s + " WHERE id = " + obj.id.to_s
    end

    def self.findbyid(cl,id)
        data = @@db.execute "SELECT * FROM " + cl.to_s + " WHERE id = " + id.to_s
        obj = cl.new.setarray(data.flatten)
        return obj
    end

end



