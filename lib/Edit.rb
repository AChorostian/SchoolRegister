class Edit

    def self.StudentName(student_id,student_nr)
        student = Student.where(id: student_id).first
        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        student.printline(student_nr)
        puts ""
        print "Podaj nowe imię ucznia : "
        student.name = gets.chomp
        begin
            student.save
            puts "Poprawnie zmieniono imię ucznia."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            student.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.StudentSurname(student_id,student_nr)
        student = Student.where(id: student_id).first
        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        student.printline(student_nr)
        puts ""
        print "Podaj nowe nazwisko ucznia : "
        student.surname = gets.chomp
        begin
            student.save
            puts "Poprawnie zmieniono nazwisko ucznia."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            student.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.SubjectName(subject_id,subject_nr)
        subject = Subject.where(id: subject_id).first
        Menu.top
        puts "== Przedmiot =="
        Subject.printlabels
        subject.printline(subject_nr)
        puts ""
        print "Podaj nową nazwę przedmiotu : "
        subject.name = gets.chomp
        begin
            subject.save
            puts "Poprawnie zmieniono nazwę przedmiotu."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            subject.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.SubjectTeacher(subject_id,subject_nr)
        subject = Subject.where(id: subject_id).first
        Menu.top
        puts "== Przedmiot =="
        Subject.printlabels
        subject.printline(subject_nr)
        puts "== Nauczyciele =="
        Teacher.printlabels
        Teacher.each_with_index { |t,i| t.printline(i)  }
        puts ""
        print "Wybierz nr nowego nauczyciela : "
        subject.Teacher_id = Teacher.to_a[gets.to_i-1].id
        begin
            subject.save
            puts "Poprawnie zmieniono nauczyciela przedmiotu."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            subject.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.TeacherName(teacher_id,teacher_nr)
        teacher = Teacher.where(id: teacher_id).first
        Menu.top
        puts "== Nauczyciel =="
        Teacher.printlabels
        teacher.printline(teacher_nr)
        puts ""
        print "Podaj nowe imię nauczyciela : "
        teacher.name = gets.chomp
        begin
            teacher.save
            puts "Poprawnie zmieniono imię nauczyciela."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            teacher.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.TeacherSurname(teacher_id,teacher_nr)
        teacher = Teacher.where(id: teacher_id).first
        Menu.top
        puts "== Nauczyciel =="
        Teacher.printlabels
        teacher.printline(teacher_nr)
        puts ""
        print "Podaj nowe nazwisko nauczyciela : "
        teacher.name = gets.chomp
        begin
            teacher.save
            puts "Poprawnie zmieniono nazwisko nauczyciela."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            teacher.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.NoteDate(note_id,note_nr,student_nr)
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
        print "Podaj nową datę uwagi : "
        note.date = gets.chomp
        begin
            note.save
            puts "Poprawnie zmieniono datę."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            note.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.NoteDescription(note_id,note_nr,student_nr)
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
        print "Podaj nowy opis uwagi : "
        note.description = gets.chomp
        begin
            note.save
            puts "Poprawnie zmieniono opis."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            note.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.NoteTeacher(note_id,note_nr,student_nr)
        note = Note.where(id: note_id).first
        student = note.Student
        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        student.printline(student_nr)
        puts "== Uwaga =="
        Note.printlabels
        note.printline(note_nr)
        puts "== Nauczyciele =="
        Teacher.printlabels
        Teacher.each_with_index { |t,i| t.printline(i)  }
        puts ""
        print "Wybierz nr nowego nauczyciela : "
        note.Teacher_id = Teacher.to_a[gets.to_i-1].id
        begin
            note.save
            puts "Poprawnie zmieniono nauczyciela."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            note.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.GradeGrade(grade_id,grade_nr,studentsubject_nr,student_nr)
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
        print "Podaj nową ocenę : "
        grade.grade = gets.to_i
        begin
            grade.save
            puts "Poprawnie zmieniono ocenę."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            grade.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.GradeComment(grade_id,grade_nr,studentsubject_nr,student_nr)
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
        print "Podaj nowy komentarz : "
        grade.comment = gets.chomp
        begin
            grade.save
            puts "Poprawnie zmieniono komentarz."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            grade.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.GradeDate(grade_id,grade_nr,studentsubject_nr,student_nr)
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
        print "Podaj nową datę : "
        grade.date = gets.chomp
        begin
            grade.save
            puts "Poprawnie zmieniono datę."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            grade.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

end