class Stats

    def self.Student(student_id,student_nr)

        student = Student.where(id: student_id).first

        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        student.printline(student_nr)

            gradecount = 0
            av_subject = 0
            av_total = 0
            max_av = 0
            min_av = 6
            max_gr = Grade.where(StudentSubject_id: student.StudentSubject.first.id).to_hash.length.to_i
            min_gr = Grade.where(StudentSubject_id: student.StudentSubject.first.id).to_hash.length.to_i
            max_av_name = "Błąd"
            min_av_name = "Błąd"
            max_gr_name = student.StudentSubject.first.Subject.name
            min_gr_name = student.StudentSubject.first.Subject.name

            student.StudentSubject.each do |ss|
                grades = Grade.where(StudentSubject_id: ss.id)
                gcount = grades.to_hash.length.to_i
                gradecount += gcount
                av_temp = 0
                grades.each do |g|
                    av_temp += g.grade
                end
                av_total += av_temp
                av_temp = av_temp.to_f / gcount.to_f
                av_subject += av_temp
                if av_temp>max_av && av_temp!=0
                    max_av = av_temp
                    max_av_name = ss.Subject.name
                end
                if av_temp<min_av && av_temp!=0
                    min_av = av_temp
                    min_av_name = ss.Subject.name
                end
                if gcount>max_gr && gcount!=0
                    max_gr = gcount
                    max_gr_name = ss.Subject.name
                end
                if gcount<min_gr && gcount!=0
                    min_gr = gcount
                    min_gr_name = ss.Subject.name
                end
            end
            av_total = av_total.to_f / gradecount.to_f
            av_subject = av_subject.to_f / student.StudentSubject.length.to_f

        puts ""
        puts "Liczba przedmiotów: " + student.StudentSubject.length.to_s
        puts "Liczba wszystkich ocen: "+ gradecount.to_s
        puts "Liczba uwag: "+ student.Note.length.to_s
        puts "Średnia ze średnich ocen z przedmiotów: " + av_subject.to_s
        puts "Średnia ze wszystkich ocen ucznia: " + av_total.to_s
        puts "Najlepsza średnia: " + max_av.to_s + " z przedmiotu: " + max_av_name
        puts "Najgorsza średnia: " + min_av.to_s + " z przedmiotu: " + min_av_name
        puts "Najwięcej ocen: " + max_gr.to_s + " z przedmiotu: " + max_gr_name
        puts "Najmniej ocen: " + min_gr.to_s + + " z przedmiotu: " + min_gr_name
        puts ""
        print "Podaj dowolny znak, aby wrócić: "
        gets
    end



end