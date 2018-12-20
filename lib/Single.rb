class Single

    def self.Student(student_id,student_nr)

        student = Student.where(id: student_id).first

        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        student.printline(student_nr)
        puts ""
        puts "1. Lista przedmiotów"
        puts "2. Lista uwag"
        puts ""
        puts "3. Dopisz przedmiot"
        puts "4. Dodaj uwagę"
        puts ""
        puts "5. Edytuj imię"
        puts "6. Edytuj nazwisko"
        puts ""
        puts "7. Usuń ucznia z dziennika"
        puts ""
        puts "0. Powrót"
        puts ""
        print "podaj nr: "

        case gets.to_i
        when 1 then List.StudentSubject(student_id); self.Student(student_id,student_nr)
        when 2 then List.Note(student_id) ; self.Student(student_id,student_nr)
        when 3 then exit
        when 4 then exit
        when 5 then exit
        when 6 then exit
        when 7 then student.cascadedelete
        end
    end

    def self.Subject(subject_id,subject_nr)

        subject = Subject.where(id: subject_id).first

        Menu.top
        puts "== Przedmiot =="
        Subject.printlabels
        subject.printline(subject_nr)
        puts ""
        puts "1. Edytuj nazwę"
        puts "2. Zmień nauczyciela"
        puts ""
        puts "3. Usun przedmiot"
        #puts "4. Pokaż listę uczęszczających uczniów"
        #puts "5. Pokaż dane statystyczne" #np srednia z ocen, laczna ilosc ocen...
        puts ""
        puts "0. Powrót"
        puts ""
        print "podaj nr: "

        case gets.to_i
        when 1 then exit
        when 2 then exit
        when 3 then subject.cascadedelete
        when 4 then exit
        when 5 then exit
        else exit
        end
    end

    def self.Teacher(teacher_id,teacher_nr)

        teacher = Teacher.where(id: teacher_id).first

        Menu.top
        puts "== Nauczyciel =="
        Teacher.printlabels
        teacher.printline(teacher_nr)
        puts ""
        puts "1. Edytuj imię"
        puts "2. Edytuj nazwisko"
        puts ""
        puts "3. Usun nauczyciela"
        #puts "4. Pokaż listę uczonych przedmiotów"
        #puts "5. Pokaż dane statystyczne" #np srednia z ocen, laczna ilosc ocen, ilosc uwag
        puts ""
        puts "0. Powrót"
        puts ""
        print "podaj nr: "

        case gets.to_i
        when 1 then exit
        when 2 then exit
        when 3 then teacher.cascadedelete
        when 4 then exit
        when 5 then exit
        else exit
        end
    end

    def self.Note(note_id,note_nr)

        note = Note.where(id: note_id).first
        student = note.Student

        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        student.printline(student.id-1)
        puts "== Uwaga =="
        Note.printlabels
        note.printline(note_nr)
        puts ""
        puts "1. Edytuj datę"
        puts "2. Edytuj opis"
        puts "3. Zmień nauczyciela"
        puts ""
        puts "4. Usuń uwagę"
        #puts "5. Pokaż nauczyciela, który wystawił uwagę"
        puts ""
        puts "0. Powrót"
        puts ""
        print "podaj nr: "

        case gets.to_i
        when 1 then exit
        when 2 then exit
        when 3 then exit
        when 4 then note.cascadedelete
        when 5 then exit
        else exit
        end
    end

    def self.StudentSubject(studentsubject_id,studentsubject_nr)

        studentsubject = StudentSubject.where(id: studentsubject_id).first
        student = studentsubject.Student

        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        student.printline(student.id-1)
        puts "== Przedmiot =="
        StudentSubject.printlabels
        studentsubject.printline(studentsubject_nr)
        puts ""
        puts "1. Lista ocen"
        puts ""
        puts "2. Wypisz ucznia"
        puts ""
        #puts "3. Przejdź do podglądu przedmiotu"
        #puts "4. Przejdź do podglądu nauczyciela"
        #puts "5. Pokaż listę uczęszczających uczniów"
        #puts "6. Pokaż dane statystyczne" #np srednia z ocen, laczna ilosc ocen...
        puts ""
        puts "0. Powrót"
        puts ""
        print "podaj nr: "

        case gets.to_i
        when 1 then List.Grade(studentsubject_id,studentsubject_nr); self.StudentSubject(studentsubject_id,studentsubject_nr)
        when 2 then studentsubject.cascadedelete
        when 3 then exit
        when 4 then exit
        when 5 then exit
        when 6 then exit
        else exit
        end
    end

    def self.Grade(grade_id,grade_nr,studentsubject_nr)

        grade = Grade.where(id: grade_id).first
        studentsubject = grade.StudentSubject
        student = studentsubject.Student

        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        student.printline(student.id-1)
        puts "== Przedmiot =="
        StudentSubject.printlabels
        studentsubject.printline(studentsubject_nr)
        puts "== Ocena =="
        Grade.printlabels
        grade.printline(grade_nr)
        puts ""
        puts "1. Edytuj ocenę"
        puts "2. Edytuj komentarz"
        puts "3. Edytuj datę"
        puts ""
        puts "4. Usuń ocenę"
        puts ""
        puts "0. Powrót"
        puts ""
        print "podaj nr: "

        case gets.to_i
        when 1 then exit
        when 2 then exit
        when 3 then exit
        when 4 then grade.cascadedelete
        else exit
        end
    end

end