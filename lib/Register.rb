require 'Student'
require 'Subject'
require 'Teacher'
require 'Grade'
require 'Note'
require 'Database'

class Register
    def self.drawmenu
        puts "============DZENNIK"
        puts "do"
    end
end

Database.init

s = Student.new
s.id = 2
s.name = "afawfwa"
s.surname = "afawfawfwafaw"

s2 = Student.new.sethash({ id: 0 , name: "dada" , surname: "wadwaawawdwda"})

s3 = Student.new.setarray([0,"afaw","awfwagsh"])

Database.add s
Database.add s2
Database.add s3

s3 = Student.new.setarray([3,"jan","kowalski"])
Database.update s3

#puts s.gethash.keys.to_s.delete("[:]")
#puts s.gethash.values.to_s.delete("[:]")


puts Database.findbyid(Student,2).gethash

print "\n"

Database.findall(Student).each do |obj|
    puts obj.gethash.to_s
end
