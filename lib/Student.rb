class Student < Sequel::Model(Database.db[:Student])

    plugin :validation_helpers
    one_to_many :StudentSubject
    one_to_many :Note

    def validate
        super
        validates_presence [:name,:surname], message: 'Nie podano wszystkich niezbędnych danych.'
        validates_type String, [:name, :surname], message: 'Nieprawidłowy typ danych dla imienia/nazwiska.'
        validates_length_range 3..50, [:name,:surname], message: lambda{|s| "Opis powinien mieć więcej niż #{s} znaków"}
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
        self.StudentSubject.each do |s|
            s.cascadedelete
        end
        self.delete
    end

end