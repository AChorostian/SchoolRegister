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
        when 1 then List.StudentSubject(student_id,student_nr); self.Student(student_id,student_nr)
        when 2 then List.Note(student_id,student_nr) ; self.Student(student_id,student_nr)
        when 3 then Add.StudentSubject(student_id); self.Student(student_id,student_nr)
        when 4 then Add.Note(student_id) ; self.Student(student_id,student_nr)
        when 5 then Edit.StudentName(student_id,student_nr); self.Student(student_id,student_nr)
        when 6 then Edit.StudentSurname(student_id,student_nr); self.Student(student_id,student_nr)
        when 7 then student.delete
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
        when 1 then Edit.SubjectName(subject_id,subject_nr); self.Subject(subject_id,subject_nr)
        when 2 then Edit.SubjectTeacher(subject_id,subject_nr); self.Subject(subject_id,subject_nr)
        when 3 then subject.delete
        when 4 then exit
        when 5 then exit
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
        when 1 then Edit.TeacherName(teacher_id,teacher_nr); self.Teacher(teacher_id,teacher_nr)
        when 2 then Edit.TeacherSurname(teacher_id,teacher_nr); self.Teacher(teacher_id,teacher_nr)
        when 3 then teacher.delete
        when 4 then exit
        when 5 then exit
        end
    end

    def self.Note(note_id,note_nr,student_nr)

        note = Note.where(id: note_id).first
        student = note.Student

        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        student.printline(student_nr)
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
        when 1 then Edit.NoteDate(note_id,note_nr,student_nr); self.Note(note_id,note_nr,student_nr)
        when 2 then Edit.NoteDescription(note_id,note_nr,student_nr); self.Note(note_id,note_nr,student_nr)
        when 3 then Edit.NoteTeacher(note_id,note_nr,student_nr); self.Note(note_id,note_nr,student_nr)
        when 4 then note.delete
        when 5 then exit
        end
    end

    def self.StudentSubject(studentsubject_id,studentsubject_nr,student_nr)

        studentsubject = StudentSubject.where(id: studentsubject_id).first
        student = studentsubject.Student

        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        student.printline(student_nr)
        puts "== Przedmiot =="
        StudentSubject.printlabels
        studentsubject.printline(studentsubject_nr)
        puts ""
        puts "1. Lista ocen"
        puts "2. Dodaj ocenę"
        puts ""
        puts "3. Wypisz ucznia"
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
        when 1 then List.Grade(studentsubject_id,studentsubject_nr,student_nr); self.StudentSubject(studentsubject_id,studentsubject_nr,student_nr)
        when 2 then Add.Grade(studentsubject_id); self.StudentSubject(studentsubject_id,studentsubject_nr,student_nr)
        when 3 then studentsubject.delete
        when 4 then exit
        when 5 then exit
        when 6 then exit
        end
    end

    def self.Grade(grade_id,grade_nr,studentsubject_nr,student_nr)

        grade = Grade.where(id: grade_id).first
        studentsubject = grade.StudentSubject
        student = studentsubject.Student

        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        student.printline(student_nr)
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
        when 1 then Edit.GradeGrade(grade_id,grade_nr,studentsubject_nr,student_nr); self.Grade(grade_id,grade_nr, studentsubject_nr,student_nr)
        when 2 then Edit.GradeComment(grade_id,grade_nr,studentsubject_nr,student_nr); self.Grade(grade_id,grade_nr, studentsubject_nr,student_nr)
        when 3 then Edit.GradeDate(grade_id,grade_nr,studentsubject_nr,student_nr); self.Grade(grade_id,grade_nr, studentsubject_nr,student_nr)
        when 4 then grade.delete
        end
    end

end