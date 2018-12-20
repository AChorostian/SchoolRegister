class Teacher < Sequel::Model(Database.db[:Teacher])

    plugin :validation_helpers
    one_to_many :Subject
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