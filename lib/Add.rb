class Add

    def self.Student
        student = Student.new
        Menu.top
        puts "== Nowy uczeń =="
        puts ""
        print "Imię : "
        student.name = gets.chomp
        print "Nazwisko : "
        student.surname = gets.chomp
        puts ""
        begin
            student.save
            puts "Poprawnie dodano ucznia."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            subject.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.Subject
        subject = Subject.new
        Menu.top
        puts "== Nowy przedmiot =="
        puts ""
        print "Nazwa : "
        subject.name = gets.chomp
        puts ""
        Teacher.printlabels
        Teacher.each_with_index { |s,i| s.printline(i) }
        puts ""
        print "Numer nauczyciela : "
        subject.Teacher_id = gets.chomp
        puts ""
        begin
            subject.save
            puts "Poprawnie dodano przedmiot."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            subject.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.Teacher
        teacher = Teacher.new
        Menu.top
        puts "== Nowy Nauczyciel =="
        puts ""
        print "Imię : "
        teacher.name = gets.chomp
        print "Nazwisko : "
        teacher.surname = gets.chomp
        puts ""
        begin
            teacher.save
            puts "Poprawnie dodano nauczyciela."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            subject.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

    def self.Note(student_id)
        note = Note.new
        Menu.top
        puts "== Nowa uwaga =="
        puts ""
        print "Opis : "
        note.description = gets.chomp
        print "Data : "
        note.date = gets.chomp
        puts ""
        Teacher.printlabels
        Teacher.each_with_index { |s,i| s.printline(i) }
        puts ""
        print "Numer nauczyciela : "
        note.Teacher_id = gets.chomp
        note.Student_id = student_id
        puts ""
        begin
            note.save
            puts "Poprawnie dodano uwagę."
            puts "Podaj dowolny znak, aby wrócić."
            gets
        rescue Exception
            note.errors.values.flatten.each { |e| puts e }
            puts "Podaj dowolny znak, aby wrócić."
            puts "Następnie będzie można spróbować ponownie."
            gets
        end
    end

end