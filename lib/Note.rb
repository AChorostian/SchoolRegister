require 'sequel'
class Note < Sequel::Model(Database.db[:Note])

    plugin :validation_helpers
    many_to_one :Teacher
    many_to_one :Student

    def validate
        super
        validates_presence [:description,:date,:Student_id,:Teacher_id], message: 'Nie podano wszystkich niezbędnych danych.'
        validates_type String, :description, message: 'Nieprawidłowy typ danych dla opisu.'
        validates_type String, :date, message: 'Nieprawidłowy typ danych dla daty.'
        validates_type Integer, :Teacher_id, message: 'Nieprawidłowy typ danych dla nauczyciela.'
        validates_type Integer, :Student_id, message: 'Nieprawidłowy typ danych dla ucznia.'
        validates_length_range 3..500, :description, message: lambda{|s| "Opis powinien mieć więcej niż #{s} znaków"}
        errors.add(:Teacher_id, 'Dany nauczyciel nie istnieje!') if Teacher[self[:Teacher_id].to_i] == nil
        errors.add(:Student_id, 'Dany uczeń nie istnieje!') if Student[self[:Student_id].to_i] == nil
        validates_format /^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$/, :date, message: "Zły format dla daty - użyj formatu dd.mm.yyyy"

        errors.add(:Teacher_id, 'Błędne przypisanie dla nauczyciela!') if self[:Teacher_id].to_i <= 0
        errors.add(:Student_id, 'Błędne przypisanie dla ucznia!') if self[:Student_id].to_i <= 0
    end

    def self.printlabels
        puts " Nr |       Data |            Nauczyciel | Opis"
        puts "----+------------+-----------------------|--------"
    end

    def printline(nr)
        teacher_string = self.Teacher.name + " " + self.Teacher.surname
        printf("%3d |%11s |%22s | %s\n" , nr+1 , date.to_s , teacher_string , description.to_s )
    end

    def cascadedelete
        self.delete
    end

end


