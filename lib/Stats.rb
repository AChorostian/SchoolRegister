class Stats

    def self.Student(student_id,student_nr)
        student = Student[student_id]
        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        student.printline(student_nr)
        puts ""
        puts "Liczba przedmiotów: " + student.count_subjects.to_s
        puts "Liczba wszystkich ocen: " + student.count_grades.to_s
        puts "Liczba uwag: "+ student.count_notes.to_s
        puts "Średnia ze średnich ocen z przedmiotów: " + student.average_average_grades.to_s
        puts "Średnia ze wszystkich ocen ucznia: " + student.average_grades.to_s
        puts "Najlepsza średnia: " + student.max_average_grades.average_grades.to_s + " " + student.max_average_grades.Subject.name.to_s
        puts "Najgorsza średnia: " + student.min_average_grades.average_grades.to_s + " " + student.min_average_grades.Subject.name.to_s
        puts "Najwięcej ocen: " + student.max_count_grades.count_grades.to_s + " " + student.max_count_grades.Subject.name.to_s
        puts "Najmniej ocen: " + student.min_count_grades.count_grades.to_s + " " + student.min_count_grades.Subject.name.to_s
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
        puts ""
        puts "Liczba przypisanych uczniów: " + subject.count_students.to_s
        puts "Liczba wszystkich wystawionych ocen: " + subject.count_grades.to_s
        puts "Średnia ze średnich wszystkich uczniów: " + subject.average_average_grades.to_s
        puts "Średnia ze wszystkich wystawionych ocen: " + subject.average_grades.to_s
        puts "Średnia ilość ocen przypadających na ucznia: " + subject.average_count_grades.to_s
        puts "Najlepsza średnia: " + subject.max_average_grades.average_grades.to_s + " " + subject.max_average_grades.Student.name + " " + subject.max_average_grades.Student.surname
        puts "Najgorsza średnia: " + subject.min_average_grades.average_grades.to_s + " " + subject.min_average_grades.Student.name + " " + subject.min_average_grades.Student.surname
        puts "Najwiejsza ilość ocen: " + subject.max_count_grades.count_grades.to_s + " " + subject.max_count_grades.Student.name + " " + subject.max_count_grades.Student.surname
        puts "Najmniejsza ilość ocen: " + subject.min_count_grades.count_grades.to_s + " " + subject.min_count_grades.Student.name + " " + subject.min_count_grades.Student.surname
        puts ""
        print "Podaj dowolny znak, aby wrócić: "
        gets
    end
end