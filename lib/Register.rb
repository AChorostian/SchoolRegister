require_relative 'Student'
require_relative 'Subject'
require_relative 'Teacher'
require_relative 'Grade'
require_relative 'Note'
require_relative 'Database'
require_relative 'CsvManager'
require_relative 'Menu'

class Register

end
  def initialize
    Database.init
    CsvManager.importFromCsv("data/students.csv",Student )
    CsvManager.importFromCsv("data/teachers.csv",Teacher )
    CsvManager.importFromCsv("data/subjects.csv",Subject )
    Menu.main
  end
end


#CsvManager.saveToFile("students.csv", Database.findall(Student))
#CsvManager.saveToFile("teachers.csv", Database.findall(Teacher))