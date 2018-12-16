class Menu

  def self.main
    top
    arr = [method(:exit)]
    arr << method(:listofstudents)
    arr << method(:listofsubjects)
    arr << method(:listofteachers)

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
    arr[gets.to_i].call
  end

  def self.listofstudents
    top
    puts " Nr |        Imię |     Nazwisko "
    puts "----+-------------+--------------"
    Database.findall(Student).each do |v|
      printf("%3d |%12s |%13s\n" , v[:id] , v[:name] , v[:surname])
    end
    puts ""
    puts "Wybierz ucznia podając jego nr lub 0, aby wyjść"
    print "podaj nr: "
    n = gets.to_i
    if (n == 0)
        main
    else
        selectedstudent(n)
    end
  end

  def self.listofsubjects
    top
    puts " Nr |        Nazwa |             Nauczyciel "
    puts "----+--------------+------------------------"
    Database.findall(Subject).each do |v|
        t = Database.findbyid(Teacher,v[:teacher_id])
        ts = t.name + " " + t.surname
        printf("%3d |%13s |%23s\n" , v[:id] , v[:name] , ts )
    end
    puts ""
    puts "Wybierz przedmiot podając jego nr lub 0, aby wyjść"
    print "podaj nr: "
    n = gets.to_i
    if (n == 0)
      main
    else
      selectedsubject(n)
    end
  end

  def self.listofteachers
    top
    puts " Nr |        Imię |     Nazwisko "
    puts "----+-------------+--------------"
    Database.findall(Teacher).each do |v|
      printf("%3d |%12s |%13s\n" , v[:id] , v[:name] , v[:surname])
    end
    puts ""
    puts "Wybierz nauczyciela podając jego nr lub 0, aby wyjść"
    print "podaj nr: "
    n = gets.to_i
    if (n == 0)
      main
    else
      selectedteacher(n)
    end
  end

  def self.listofstudentsubjects(n)
      top
      puts " Nr |        Nazwa "
      puts "----+--------------"

      Database.findbykeyandvalue(StudentSubject,"student_id",n.to_s).each_with_index do |v,i|
          s = Database.findbyid(Subject,v[:subject_id]).name
          nr = i+1
          printf("%3d |%13s\n" , nr , s )
      end
      puts ""
      puts "Wybierz przedmiot podając jego nr lub 0, aby wyjść"
      print "podaj nr: "
  end

  def self.selectedstudent(n)
    top
    h = Database.findbyid(Student,n).gethash
    puts "       Nr | " + h[:id].to_s
    puts "----------+---------"
    puts "     Imię | " + h[:name].to_s
    puts "----------+---------"
    puts " Nazwisko | " + h[:surname].to_s
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
    n2 = gets.to_i
    if (n2 == 0)
        main
    else
        if (n2 == 1)
            listofstudentsubjects n
        end
    end
  end

  def self.selectedsubject(n)
    top
    h = Database.findbyid(Subject,n).gethash
    t = Database.findbyid(Teacher,h[:teacher_id])
    ts = t.name + " " + t.surname
    puts "         Nr | " + h[:id].to_s
    puts "------------+---------"
    puts "      Nazwa | " + h[:name].to_s
    puts "------------+---------"
    puts " Nauczyciel | " + ts
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

  def self.selectedteacher(n)
    top
    h = Database.findbyid(Teacher,n).gethash
    puts "       Nr | " + h[:id].to_s
    puts "----------+---------"
    puts "     Imię | " + h[:name].to_s
    puts "----------+---------"
    puts " Nazwisko | " + h[:surname].to_s
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

    def self.exit
        top
        puts "Dziękujemy za korzystanie z naszej aplikacji! ;)"
    end

    def self.top
        system 'clear'
        puts "==================== DZENNIK ===================="
    end

end