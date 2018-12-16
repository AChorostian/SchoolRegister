class Menu

  def self.main
      top
      puts "1. Lista Uczniów"
      puts "2. Lista Przedmiotów"
      puts "3. Lista Nauczycieli"
      puts ""
      puts "4. Dodaj Ucznia"
      puts "5. Dodaj Przedmiot"
      puts "6. Dodaj Nauczyciela"
      puts ""
      puts "7. Statystyki"
      puts ""
      puts "0. Wyjscie"
      puts ""
      print "podaj nr: "
      case gets.to_i
      when 1
          list(Student)
          main
      when 2
          list(Subject)
          main
      when 3
          list(Teacher)
          main
      when 4
          addstudent
          main
      when 0
          exit
      else
          "wtf"
      end

  end

  def self.list(cl)
      top
      cl.printlabels
      Database.findall(cl).each_with_index do |v,i|
          cl.new.sethash(v).printline(i+1)
      end
      puts ""
      puts "Wybierz nr lub 0, aby wyjść"
      print "podaj nr: "
      input = gets.to_i
      if input != 0
          selected(cl,input)
          list(cl)
      end
  end

  def self.listext(cl,key,value)
      top
      puts "EXT"
      cl.printlabels
      data = Database.findbykeyandvalue(cl,key.to_s,value.to_s)
      data.each_with_index do |obj,i|
          obj.printline(i+1)
      end
      puts ""
      puts "Wybierz nr lub 0, aby wyjść"
      print "podaj nr: "
      input = gets.to_i
      if (input != 0)
          case cl.to_s
          when "StudentSubject"
              selectedstudentsubject(data[input-1].id,input)
              listext(cl,key,value)
          when "Note"
              selectednote(data[input-1].id,input)
              listext(cl,key,value)
          when "Grade"
              selectedgrade(data[input-1].id,input)
              listext(cl,key,value)
          end
      end
  end


  def self.listofstudentsubjects(student_id)
      top
      StudentSubject.printlabels
      data = Database.findbykeyandvalue(StudentSubject,"student_id",student_id.to_s)
      data.each_with_index do |studentsubject,i|
          studentsubject.printline(i+1)
      end
      puts ""
      puts "Wybierz nr lub 0, aby wyjść"
      print "podaj nr: "
      input = gets.to_i
      if (input == 0)
          selectedstudent(student_id)
      else
          selectedstudentsubject(data[input-1].id,input)
      end
  end

  def self.listofnotes(student_id)
      top
      Note.printlabels
      data = Database.findbykeyandvalue(Note,"student_id",student_id.to_s)
      data.each_with_index do |note,i|
          note.printline(i+1)
      end
      puts ""
      puts "Wybierz nr lub 0, aby wyjść"
      print "podaj nr: "
      input = gets.to_i
      if (input == 0)
          selectedstudent(student_id)
      else
          selectednote(data[input-1].id,input)
      end
  end

  def self.listofgrades(studentsubject_id)
    top
    Grade.printlabels
    data = Database.findbykeyandvalue(Grade,"studentsubject_id",studentsubject_id.to_s)
    data.each_with_index do |grade,i|
        grade.printline(i+1)
    end
    puts ""
    puts "Wybierz nr lub 0, aby wyjść"
    print "podaj nr: "
    input = gets.to_i
    if (input == 0)
        selectedstudentsubject(studentsubject_id,nr)
    else
        selectedgrade(data[input-1].id,input)
    end
  end

  def self.selected(cl,id)
      if cl == Student
          selectedstudent(id)
      end
      if cl == Subject
          selectedsubject(id)
      end
      if cl == Teacher
          selectedteacher(id)
      end
  end

  def self.selectedstudent(student_id)
    top
    Student.printlabels
    Database.findbyid(Student,student_id).printline(student_id)
    puts ""
    puts "1. Lista przedmiotów"
    puts "2. Lista uwag"
    puts ""
    puts "3. Dopisz przedmiot"
    puts "4. Dodaj uwagę"
    puts "5. Edytuj dane ucznia"
    puts "6. Usuń ucznia z dziennika"
    puts ""
    puts "0. Powrót"
    puts ""
    print "podaj nr: "
    input = gets.to_i
    if (input == 0)
        main
    else
        if (input == 1)
            listext(StudentSubject,"student_id",student_id)
        end
        if (input == 2)
            listext(Note,"student_id",student_id)
        end
        if (input == 5)
          editstudent(Database.findbyid(Student,student_id),true)
          main
        end
    end
  end

  def self.selectedsubject(subject_id)
    top
    Subject.printlabels
    Database.findbyid(Subject,subject_id).printline(subject_id)
    puts ""
    puts "1. Edytuj nazwę"
    puts "2. Edytuj nauczyciela"
    puts ""
    puts "3. Usuń przedmiot (oraz wszystkie powiązania)"
    puts ""
    puts "0. Powrót"
    puts ""
    print "podaj nr: "
  end

  def self.selectedteacher(teacher_id)
    top
    Teacher.printlabels
    Database.findbyid(Teacher,teacher_id).printline(teacher_id)
    puts ""
    puts "1. Lista nauczanych przedmiotów"
    puts ""
    puts "2. Edytuj dane nauczyciela"
    puts "3. Usuń nauczyciela (oraz wszystkie powiązania)"
    puts ""
    puts "0. Powrót"
    puts ""
    print "podaj nr: "
  end

  def self.selectedstudentsubject(studentsubject_id,nr)
    top
    studentsubject = Database.findbyid(StudentSubject,studentsubject_id)
    subject_hash = Database.findbyid(Subject,studentsubject.subject_id).gethash
    teacher = Database.findbyid(Teacher,subject_hash[:teacher_id])
    teacher_string = teacher.name + " " + teacher.surname
    puts "         Nr | " + nr.to_s
    puts "------------+---------"
    puts "      Nazwa | " + subject_hash[:name].to_s
    puts "------------+---------"
    puts " Nauczyciel | " + teacher_string
    puts ""
    puts "1. Lista ocen"
    puts "2. Dodaj ocenę"
    puts ""
    puts "3. Wypisz ucznia z tego przedmiotu (oraz usuń wszystkie powiązania)"
    puts ""
    puts "0. Powrót"
    puts ""
    print "podaj nr: "
    input = gets.to_i
    if (input == 0)
      main
    else
      if (input == 1)
        listofgrades(studentsubject_id)
      end
    end
  end

  def self.selectednote(note_id,nr)
    top
    note = Database.findbyid(Note,note_id)
    teacher = Database.findbyid(Teacher,note.teacher_id)
    teacher_string = teacher.name + " " + teacher.surname
    puts "         Nr | " + nr.to_s
    puts "------------+---------"
    puts "       Data | " + note.date.to_s
    puts "------------+---------"
    puts " Nauczyciel | " + teacher_string
    puts "------------+---------"
    puts "       Opis | " + note.description
    puts ""
    puts "1. Edytuj uwagę"
    puts "2. Usuń uwagę"
    puts ""
    puts "0. Powrót"
    puts ""
    print "podaj nr: "
  end

  def self.selectedgrade(grade_id,nr)
    top
    grade_hash = Database.findbyid(Grade,grade_id).gethash
    puts "         Nr | " + nr.to_s
    puts "------------+---------"
    puts "      Ocena | " + grade_hash[:grade].to_s
    puts "------------+---------"
    puts "  Komentarz | " + grade_hash[:comment].to_s
    puts "------------+---------"
    puts "       Data | " + grade_hash[:date].to_s
    puts ""
    puts "1. Edytuj ocenę"
    puts "2. Usuń ocenę"
    puts ""
    puts "0. Powrót"
    puts ""
    print "podaj nr: "
  end

  def self.addstudent()

    student = Student.new
    puts "Podaj dane ucznia albo wpisz 0 aby anulować operacje"
    puts "     Imię | "
    puts "----------+---------"
    puts " Nazwisko | "

    print "Podaj imie ucznia: "
    string = getwithregex()
    if (string == 0)
      return
    end
    name = nameFormat(string)
    puts "     Imię | " + name
    puts "----------+---------"
    puts " Nazwisko | "

    string = getwithregex()
    if (string == 0)
      return
    end
    surname = nameFormat(string)

    student.name = name
    student.surname = surname

    while true do
      puts "     Imię | " + name
      puts "----------+---------"
      puts " Nazwisko | " + surname

      puts "Wszystko sie zgadza? (T/N)"

      accept = gets[0]

      if (accept == "T")
        Database.add student
        break
      else
        puts "Czy chcesz poprawić dane? T/N)"
        fixAccept = gets[0]
        if (fixAccept == "T")
          editstudent(student)
          next
        else
          puts "Operacja dodawania ucznia anulowana"
          break
        end
      end
    end
    main

  end

  def self.editstudent(student, existsindb=false)
    input = 1
    until input == 0
      student_hash = student.gethash
      puts "1     Imię | " + student_hash[:name].to_s
      puts "----------+---------"
      puts "2 Nazwisko | " + student_hash[:surname].to_s
      puts ""
      puts "0 Wszystko jest ok"
      puts "1 Popraw imie"
      puts "2 Popraw nazwisko"
      input = gets.to_i
      changestudentField(student,input, existsindb)
    end
  end

  def self.nameFormat(string)

    return string.slice(0,1).capitalize + string.slice(1..-1).downcase

  end

  def self.changestudentField(student, field_num, existsindb=false)

    if (field_num == 0)
      return
    end
    if (field_num == 1)
      print "Podaj imie ucznia: "
      new_name = getwithregex()
      if (new_name == 0)
        return
      end
      student.name = nameFormat(new_name)
    elsif (field_num == 2)
      print "Podaj nazwisko ucznia: "
      new_surname = getwithregex()
      if (new_surname == 0)
        return
      end
      student.surname = nameFormat(new_surname)
    end


      if (existsindb)
        Database.update(student)
      end


  end

  def self.getwithregex(regex = /^[a-z ĄąĆćĘęŁłŃńÓóŚśŹźŻż,.'-]+$/i)

    begin
      string = gets.chomp.to_s
      if (string == "0")
        puts "Przerwano operacje"
        return 0
      end
      if (string =~ regex)
        break
      end
      puts "Niepoprawne dane (podaj jeszcze raz albo anuluj wpisujac 0)"
    end while true
    return string
  end

  def self.exit
      top
      puts "Dziękujemy za korzystanie z naszej aplikacji! ;)"
      abort
  end

  def self.top
    system 'clear'
    puts "==================== DZENNIK ===================="
  end

end