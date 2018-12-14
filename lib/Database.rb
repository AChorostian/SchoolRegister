require 'sqlite3'

# NOTES
#
# sqlite available types: BLOB, TEXT, INTEGER, REAL, NUMERIC

class Database

    @@db = SQLite3::Database.open "database.db"

    def self.init
        @@db.execute "CREATE TABLE IF NOT EXISTS Student(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR(255) NOT NULL,
            surname VARCHAR(255) NOT NULL
            )"
        @@db.execute "CREATE TABLE IF NOT EXISTS Teacher(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR(255) NOT NULL,
            surname VARCHAR(255) NOT NULL
            )"
        @@db.execute "CREATE TABLE IF NOT EXISTS Subject(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR(255) NOT NULL,
            teacher_id INTEGER NOT NULL REFERENCES Teacher(id)
            )"
        @@db.execute "CREATE TABLE IF NOT EXISTS Note(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            description VARCHAR(255) NOT NULL,
            date DATETIME,
            student_id INTEGER NOT NULL REFERENCES Student(id),
            teacher_id INTEGER NOT NULL REFERENCES Teacher(id)
            )"

        @@db.execute "CREATE TABLE IF NOT EXISTS Grade(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            grade INTEGER NOT NULL,
            category TEXT,
            date DATETIME NOT NULL,
            subject_id INTEGER NOT NULL REFERENCES Subject(id),
            student_id INTEGER NOT NULL REFERENCES Student(id)
            )"
        @@db.execute "CREATE TABLE IF NOT EXISTS StudentSubject(
            subject_id INTEGER NOT NULL REFERENCES Subject(id),
            student_id INTEGER NOT NULL REFERENCES Student(id),
            PRIMARY KEY(subject_id, student_id)
            )"
        @@db.execute "DELETE FROM StudentSubject"
        @@db.execute "DELETE FROM Grade"
        @@db.execute "DELETE FROM Note"
        @@db.execute "DELETE FROM Subject"
        @@db.execute "DELETE FROM Teacher"
        @@db.execute "DELETE FROM Student"
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

    def self.findall(cl)
        objarray = []
        data = @@db.execute "SELECT * FROM " + cl.to_s
        data.each do |row|
            objarray << cl.new.setarray(row.flatten)
        end
        return objarray
    end

end



