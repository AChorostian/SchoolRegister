class Menu

  def self.main
    arr = [method(:exit)]
    puts "==================== DZENNIK ===================="
    puts "1. Lista Uczniów"
    arr << method(:listofstudents)
    puts "2. Lista Przedmiotów"
    arr << method(:listofsubjects)
    puts "3. Lista Nauczycieli"
    arr << method(:listofteachers)
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
    puts "==================== DZENNIK ===================="
    puts " Nr |        Imię |     Nazwisko "
    puts "----+-------------+--------------"
    Database.findall(Student).each do |v|
        printf("%3d |%12s |%13s\n" , v[:id] , v[:name] , v[:surname])
    end
    puts ""
    puts "Wybierz ucznia podając jego nr lub 0, aby wyjść"
    print "podaj nr: "
    n = gets
    if (n == 0)
        main
    else
        selectedstudent(n)
    end
  end

  def self.listofsubjects
    puts "==================== DZENNIK ===================="
    puts Database.findall(Subject)
    puts ""
    puts "Wybierz przedmiot podając jego nr lub 0, aby wyjść"
    print "podaj nr: "
  end

  def self.listofteachers
    puts "==================== DZENNIK ===================="
    puts Database.findall(Subject)
    puts ""
    puts "Wybierz nauczyciela podając jego nr lub 0, aby wyjść"
    print "podaj nr: "
  end

  def self.selectedstudent(n)
    puts "==================== DZENNIK ===================="
    puts Database.findbyid(Student,n).gethash
    puts ""
    puts "No i znaleziony"
  end

  def self.exit
    puts "papa"
  end


end