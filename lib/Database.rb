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
            foreign_key :Teacher_id, :Teacher, key: :id
        end
        @@db.create_table :Note do
            primary_key :id
            String :description
            String :date
            foreign_key :Student_id, :Student, key: :id
            foreign_key :Teacher_id, :Teacher, key: :id
        end
        @@db.create_table :StudentSubject do
            primary_key :id
            foreign_key :Student_id, :Student, key: :id
            foreign_key :Subject_id, :Subject, key: :id
            unique [:Student_id, :Subject_id]
        end
        @@db.create_table :Grade do
            primary_key :id
            String :grade
            String :comment
            String :date
            foreign_key :StudentSubject_id, :StudentSubject, key: :id
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

Database.init