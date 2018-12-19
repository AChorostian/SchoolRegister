class List

    def self.Student
        Menu.top
        puts "== Uczniowie =="
        Student.printlabels
        Student.each_with_index { |s,i| s.printline(i)  }
        puts ""
        puts "Wybierz nr lub 0, aby wyjść."
        print "podaj nr: "
        input = gets.to_i
        if input != 0
            Single.Student(input)
            self.Student
        end
    end

    def self.Subject
        Menu.top
        puts "== Przedmioty =="
        Subject.printlabels
        Subject.each_with_index { |s,i| s.printline(i)  }
        puts ""
        puts "Wybierz nr lub 0, aby wyjść."
        print "podaj nr: "
        input = gets.to_i
        if input != 0
            Single.Subject(input)
            self.Subject
        end
    end

    def self.Teacher
        Menu.top
        puts "== Nauczyciele =="
        Teacher.printlabels
        Teacher.each_with_index { |t,i| t.printline(i)  }
        puts ""
        puts "Wybierz nr lub 0, aby wyjść."
        print "podaj nr: "
        input = gets.to_i
        if input != 0
            Single.Teacher(input)
            self.Teacher
        end
    end

    def self.Note(student_id)
        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        Student.where(id: student_id).first.printline(student_id-1)
        puts "== Uwagi =="
        Note.printlabels
        Note.where(Student_id: student_id).each_with_index { |n,i| n.printline(i)  }
        puts ""
        puts "Wybierz nr lub 0, aby wyjść."
        print "podaj nr: "
        input = gets.to_i
        if input != 0
            Single.Note(Note.where(Student_id: student_id).to_a[input-1].id,input-1)
            self.Note(student_id)
        end
    end

    def self.StudentSubject(student_id)
        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        Student.where(id: student_id).first.printline(student_id-1)
        puts "== Przedmioty =="
        StudentSubject.printlabels
        StudentSubject.where(Student_id: student_id).each_with_index { |ss,i| ss.printline(i)  }
        puts ""
        puts "Wybierz nr lub 0, aby wyjść."
        print "podaj nr: "
        input = gets.to_i
        if input != 0
            Single.StudentSubject(StudentSubject.where(Student_id: student_id).to_a[input-1].id,input-1)
            self.StudentSubject(student_id)
        end
    end

    def self.Grade(studentsubject_id)
        Menu.top
        puts "== Oceny =="
        Grade.printlabels
        Grade.where(StudentSubject_id: studentsubject_id).each_with_index { |g,i| g.printline(i)  }
        puts ""
        puts "Wybierz nr lub 0, aby wyjść."
        print "podaj nr: "
        input = gets.to_i
        if input != 0
            #selected(cl,input)
            self.Grade(studentsubject_id)
        end
    end

end