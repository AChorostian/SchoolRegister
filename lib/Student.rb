class Student < Sequel::Model(Database.db[:Student])

    plugin :validation_helpers
    one_to_many :StudentSubject
    one_to_many :Note

    def validate
        super
        validates_presence [:name,:surname], message: 'was not given'
        validates_type String, [:name, :surname], message: 'wrong value type'
        validates_length_range 3..50, [:name,:surname], message: lambda{|s| "should be more than #{s} characters"}
        validates_format /^[A-ZĄĆĘŁŃÓŚŹŻ][a-ząćęłńóśźż]+(([-][A-ZĄĆĘŁŃÓŚŹŻ])[a-ząćęłńóśźż]+)?$/, :name, message: "contains invalid characters"
        validates_format /^[A-ZĄĆĘŁŃÓŚŹŻ][a-ząćęłńóśźż]+(([-][A-ZĄĆĘŁŃÓŚŹŻ])[a-ząćęłńóśźż]+)?$/, :surname, message: "contains invalid characters"
    end

    def self.printlabels
        puts " Nr |        Imię |     Nazwisko "
        puts "----+-------------+--------------"
    end

    def printline(nr)
        printf("%3d |%12s |%13s\n" , nr+1 , name , surname )
    end

end