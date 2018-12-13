require 'sqlite3'

  #simple sqllite example...

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