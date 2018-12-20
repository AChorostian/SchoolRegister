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
          when 1 then List.Student
          when 2 then List.Subject
          when 3 then List.Teacher
          when 4 then exit
          when 5 then exit
          when 6 then exit
          else exit
      end
  end

  def self.top
    system 'clear'
    puts "==================== DZIENNIK ===================="
  end

end
