class Single

    def self.Student(id)
        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        Student.where(id: id).first.printline(id-1)
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
        when 1 then List.StudentSubject(id)
        when 2 then List.Note(id)
        when 3 then exit
        when 4 then exit
        when 5 then exit
        when 6 then exit
        when 7 then exit
        else exit
        end
    end

    def self.Subject(id)
        Menu.top
        puts "== Przedmiot =="
        Subject.printlabels
        Subject.where(id: id).first.printline(id-1)
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
        when 3 then exit
        when 4 then exit
        when 5 then exit
        else exit
        end
    end

    def self.Teacher(id)
        Menu.top
        puts "== Nauczyciel =="
        Teacher.printlabels
        Teacher.where(id: id).first.printline(id-1)
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
        when 3 then exit
        when 4 then exit
        when 5 then exit
        else exit
        end
    end

    def self.Note(id,nr)
        Menu.top
        puts "== Uczeń =="
        Student.printlabels
        Note.where(id: id).first.Student.printline(Note.where(id: id).first.Student.id-1)
        puts "== Uwaga =="
        Note.printlabels
        Note.where(id: id).first.printline(nr)
        puts ""
        puts "1. Edytuj datę"
        puts "2. Edytuj opis"
        puts "3. Zmień nauczyciela"
        puts ""
        puts "4. Usun uwagę"
        #puts "5. Pokaż nauczyciela, który wystawił uwagę"
        puts ""
        puts "0. Powrót"
        puts ""
        print "podaj nr: "

        case gets.to_i
        when 1 then exit
        when 2 then exit
        when 3 then exit
        when 4 then exit
        when 5 then exit
        else exit
        end
    end

end