class Teacher < Sequel::Model(Database.db[:Teacher])

    plugin :validation_helpers
    one_to_many :Subject
    one_to_many :Note

    def validate
        super
        validates_presence [:name,:surname], message: 'Nie podano wszystkich niezbędnych danych.'
        validates_type String, :name, message: 'Nieprawidłowy typ danych dla imienia.'
        validates_type String, :surname, message: 'Nieprawidłowy typ danych dla nazwiska.'
        validates_length_range 3..50, :name, message: lambda{|s| "Imie powinno mieć więcej niż #{s} znaków"}
        validates_length_range 3..50, :surname, message: lambda{|s| "Nazwisko powinno mieć więcej niż #{s} znaków"}
        validates_format /^[A-ZĄĆĘŁŃÓŚŹŻ][a-ząćęłńóśźż]+(([-][A-ZĄĆĘŁŃÓŚŹŻ])[a-ząćęłńóśźż]+)?$/, :name, message: "Zły format imienia!"
        validates_format /^[A-ZĄĆĘŁŃÓŚŹŻ][a-ząćęłńóśźż]+(([-][A-ZĄĆĘŁŃÓŚŹŻ])[a-ząćęłńóśźż]+)?$/, :surname, message: "Zły format nazwiska!"
    end


    def self.printlabels
        puts " Nr |        Imię |     Nazwisko "
        puts "----+-------------+--------------"
    end

    def printline(nr)
        printf("%3d |%12s |%13s\n" , nr+1 , name , surname )
    end

    def cascadedelete
        self.Note.each do |n|
            n.cascadedelete
        end
        self.Subject.each do |s|
            s.cascadedelete
        end
        self.delete
    end

end