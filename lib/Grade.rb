require 'sequel'
class Grade < Sequel::Model(Database.db[:Grade])

    plugin :validation_helpers
    many_to_one :StudentSubject

    def validate
        validates_presence [:grade, :comment, :date], message: 'Nie podano wszystkich niezbędnych danych.'
        validates_includes [1,2,3,4,5,6], :grade, message: 'Nieprawidłowa wartość oceny. Dozwolone są liczby z zakresu od 1 do 6.'
        validates_type Integer, :grade, message: 'Nieprawidłowy typ danych dla oceny.'
        validates_type String, :comment, message: 'Nieprawidłowy typ danych dla komentarza.'
        validates_type String, :date, message: 'Nieprawidłowy typ danych dla daty.'

        validates_format /^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$/, :date, message: "Zły format dla daty - użyj formatu dd.mm.yyyy"
        validates_length_range 3..500, :comment, message: lambda{|s| "Komentarz powinien mieć więcej niż #{s} znaków"}
        errors.add(:StudentSubject_id, 'Błędne przypisanie dla ucznia!') if self[:StudentSubject_id].to_i <= 0
        errors.add(:StudentSubject_id, 'Dany uczeń nie istnieje') if StudentSubject[self[:StudentSubject_id].to_i] == nil

    end

    def self.printlabels
        puts " Nr | Ocena |       Komentarz |       Data "
        puts "----+-------+-----------------+------------"
    end

    def printline(nr)
        printf("%3d |%6s |%16s |%11s\n" , nr+1 , grade.to_s , comment.to_s , date.to_s)
    end

    def cascadedelete
        self.delete
    end

end
