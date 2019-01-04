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
        puts "Najlepsza średnia: " + student.max_average_grades.average_grades.to_s + student.max_average_grades.Subject.name.to_s
        puts "Najgorsza średnia: " + student.min_average_grades.average_grades.to_s + student.min_average_grades.Subject.name.to_s
        puts "Najwięcej ocen: " + student.max_count_grades.count_grades.to_s + student.max_count_grades.Subject.name.to_s
        puts "Najmniej ocen: " + student.min_count_grades.count_grades.to_s + student.min_count_grades.Subject.name.to_s
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
        puts "Liczba przypisanych uczniów: "
        puts "Liczba wszystkich wystawionych ocen: "
        puts "Średnia ze średnich wszystkich uczniów: "
        puts "Średnia ze wszystkich wystawionych ocen: "
        puts "Średnia ilość ocen przypadających na ucznia: "
        puts "Najlepszą średnią: "
        puts "Najgorszą średnią: "
        puts "Najwiejszą ilość ocen: "
        puts "Najmniejszą ilość ocen: "
        puts ""
        print "Podaj dowolny znak, aby wrócić: "
        gets
    end
end