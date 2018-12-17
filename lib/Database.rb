require 'sqlite3'
require 'sequel'

class Database

    @@db = Sequel.sqlite("database.db")

    def self.init
        drops
        @@db.create_table :Student do
            primary_key :id
            String :name
            String :surname
        end
        @@db.create_table :Teacher do
            primary_key :id
            String :name
            String :surname
        end
        @@db.create_table :Subject do
            primary_key :id
            String :name
            foreign_key :id_teacher, :Teacher, key: :id
        end
        @@db.create_table :Note do
            primary_key :id
            String :description
            String :date
            foreign_key :id_student, :Student, key: :id
            foreign_key :id_teacher, :Teacher, key: :id
        end
        @@db.create_table :StudentSubject do
            primary_key :id
            foreign_key :id_student, :Student, key: :id
            foreign_key :id_subject, :Subject, key: :id
            unique [:id_student, :id_subject]
        end
        @@db.create_table :Grade do
            primary_key :id
            String :grade
            String :comment
            String :date
            foreign_key :id_studentsubject, :StudentSubject, key: :id
        end
    end

    def self.drops
        @@db.drop_table?(:Grade)
        @@db.drop_table?(:StudentSubject)
        @@db.drop_table?(:Note)
        @@db.drop_table?(:Subject)
        @@db.drop_table?(:Teacher)
        @@db.drop_table?(:Student)
    end

    def self.db
        @@db
    end

    Database.init
end
