require 'sqlite3'
require 'sequel'

class Database

    @@db = Sequel.sqlite("database.db")


    def self.init
        drops
        @@db.create_table :Student do
            primary_key :id
            String :name, size: 50, null: false
            String :surname, size: 50, null: false
        end
        @@db.create_table :Teacher do
            primary_key :id
            String :name, size: 50, null: false
            String :surname, size: 50, null: false
        end
        @@db.create_table :Subject do
            primary_key :id
            String :name, size: 50, null: false
            foreign_key :Teacher_id, :Teacher, key: :id, on_delete: :cascade
            unique :name
        end
        @@db.create_table :Note do
            primary_key :id
            String :description, size: 500, null: false
            String :date, size: 30, null: false
            foreign_key :Student_id, :Student, key: :id, on_delete: :cascade
            foreign_key :Teacher_id, :Teacher, key: :id, on_delete: :cascade
        end
        @@db.create_table :StudentSubject do
            primary_key :id
            foreign_key :Student_id, :Student, key: :id, on_delete: :cascade
            foreign_key :Subject_id, :Subject, key: :id, on_delete: :cascade
            unique [:Student_id, :Subject_id]
        end
        @@db.create_table :Grade do
            primary_key :id
            Integer :grade
            String :comment, size: 500, null: false
            String :date, size: 30, null: false
            foreign_key :StudentSubject_id, :StudentSubject, key: :id, on_delete: :cascade
            check{grade >0 and grade <7}
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