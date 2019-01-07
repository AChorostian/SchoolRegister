class Stats

    def self.Student(student_id,student_nr)
        student = Student[student_id]
        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        student.printline(student_nr)
        data = student.get_all_data
        puts ""
        puts "Liczba przedmiotów: " + data[0].to_s
        puts "Liczba wszystkich ocen: " + data[1].to_s
        puts "Liczba uwag: "+ data[2].to_s
        puts "Średnia ze średnich ocen z przedmiotów: " + data[3].to_s
        puts "Średnia ze wszystkich ocen ucznia: " + data[4].to_s
        puts "Najlepsza średnia: " + data[5].to_s + " " + data[6].to_s
        puts "Najgorsza średnia: " + data[7].to_s + " " + data[8].to_s
        puts "Najwięcej ocen: " + data[9].to_s + " " + data[10].to_s
        puts "Najmniej ocen: " + data[11].to_s + " " + data[12].to_s
        puts ""
        print "Podaj dowolny znak, aby wrócić: "
        gets
    end

    def self.Subject(subject_id,subject_nr)
        subject = Subject.where(id: subject_id).first
        Menu.top
        puts "== Przedmiot =="
        Subject.printlabels
        subject.printline(subject_nr)
        data = subject.get_all_data
        puts ""
        puts "Liczba przypisanych uczniów: " + data[0].to_s
        puts "Liczba wszystkich wystawionych ocen: " + data[1].to_s
        puts "Średnia ze średnich wszystkich uczniów: " + data[2].to_s
        puts "Średnia ze wszystkich wystawionych ocen: " + data[3].to_s
        puts "Średnia ilość ocen przypadających na ucznia: " + data[4].to_s
        puts "Najlepsza średnia: " + data[5].to_s+ " " + data[6].to_s
        puts "Najgorsza średnia: " + data[7].to_s + " " + data[8].to_s
        puts "Najwiejsza ilość ocen: " + data[9].to_s + " " + data[10].to_s
        puts "Najmniejsza ilość ocen: " + data[11].to_s + " " + data[12].to_s
        puts ""
        print "Podaj dowolny znak, aby wrócić: "
        gets
    end

    def self.Teacher(teacher_id,teacher_nr)
        teacher = Teacher.where(id: teacher_id).first
        Menu.top
        puts "== Nauczyciel =="
        Teacher.printlabels
        teacher.printline(teacher_nr)
        data = teacher.get_all_data
        puts ""
        puts "Liczba przypisanych przedmiotów: " + data[0].to_s
        puts "Liczba wystawionych ocen: " + data[1].to_s
        puts "Liczba wystawionych uwag: " + data[2].to_s
        puts "Średnia ze średnich wszystkich uczonych przedmiotów: " + data[3].to_s
        puts "Średnia ze wszystkich wystawionych ocen: " + data[4].to_s
        puts ""
        print "Podaj dowolny znak, aby wrócić: "
        gets
    end
end