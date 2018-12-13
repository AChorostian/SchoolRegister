require 'sqlite3'

# NOTES
#
# sqlite available types: BLOB, TEXT, INTEGER, REAL, NUMERIC

class Database

    attr_reader :db

    def initialize
        begin
            @db = SQLite3::Database.open "database.db"
            @db.execute "CREATE TABLE IF NOT EXISTS Uczen(
                uczen_id INTEGER PRIMARY KEY,
                imie TEXT,
                nazwisko TEXT)"
            @db.execute "CREATE TABLE IF NOT EXISTS Ocena(
                ocena_id INTEGER PRIMARY KEY,
                ocena INTEGER,
                kategoria TEXT,
                data TEXT,
                przedmiot_id INTEGER,
                uczen_id INTEGER)"
            @db.execute "CREATE TABLE IF NOT EXISTS Przedmiot(
                przedmiot_id INTEGER PRIMARY KEY,
                nazwa TEXT,
                nauczyciel_id INTEGER)"
            @db.execute "CREATE TABLE IF NOT EXISTS Uwaga(
                uwaga_id INTEGER PRIMARY KEY,
                tresc TEXT,
                data TEXT,
                uczen_id INTEGER,
                nauczyciel_id INTEGER)"
            @db.execute "CREATE TABLE IF NOT EXISTS Nauczyciel(
                nauczyciel_id INTEGER PRIMARY KEY,
                imie TEXT,
                nazwisko TEXT)"
            @db.execute "CREATE TABLE IF NOT EXISTS UczenPrzedmiot(
                uczen_id INTEGER,
                przedmiot_id INTEGER)"
        rescue SQLite3::Exception => e
            puts "Exception occurred"
            puts e
        ensure
            @db.close if @db
        end
    end

    def createuczen uczen
        puts "xd"
    end
    def readuczen uczen_id
        puts "xd"
    end
    def updateuczen uczen
        puts "xd"
    end
    def deleteuczen uczen
      puts "xd"
    end
    def countuczen
      puts "xd"
    end

end




begin

  db = SQLite3::Database.open "database.db"

  db.execute "CREATE TABLE IF NOT EXISTS Friends(Id INTEGER PRIMARY KEY, Name TEXT)"
  db.execute "DELETE FROM Friends"
  db.execute "INSERT INTO Friends(Name) VALUES ('Tom')"
  db.execute "INSERT INTO Friends(Name) VALUES ('Rebecca')"
  db.execute "INSERT INTO Friends(Name) VALUES ('Jim')"
  db.execute "INSERT INTO Friends(Name) VALUES ('Robert')"
  db.execute "INSERT INTO Friends(Name) VALUES ('Julian')"

  id = db.last_insert_row_id
  puts "The last id of the inserted row is #{id}"

  print "\n"
  puts db.execute "SELECT * FROM Friends"

rescue SQLite3::Exception => e

  puts "Exception occurred"
  puts e

ensure
  db.close if db
end
