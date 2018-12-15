require_relative 'Student'
require_relative 'Subject'
require_relative 'Teacher'
require_relative 'Grade'
require_relative 'Note'
require_relative 'Database'
require_relative 'CsvManager'
require_relative 'Menu'

class Register

  def initialize
    Database.init
    Database.addArray CsvManager.importFromCsv("data/students.csv",Student )
    Database.addArray CsvManager.importFromCsv("data/teachers.csv",Teacher )
  end

  def run
    Menu.main
  end

end


#CsvManager.saveToFile("students.csv", Database.findall(Student))
#CsvManager.saveToFile("teachers.csv", Database.findall(Teacher))


#puts "Students"
#puts Database.findall(Student)

#puts "Teachers"
#puts Database.findall(Teacher)

