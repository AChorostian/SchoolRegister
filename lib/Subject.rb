class Subject < Sequel::Model(Database.db[:Subject])

    plugin :validation_helpers
    many_to_one :Teacher
    one_to_many :StudentSubject

    def validate
        super
        validates_presence [:name,:Teacher_id], message: 'Nie podano wszystkich niezbędnych danych.'
        validates_type String , :name, message: 'Nieprawidłowy typ danych dla imienia/nazwiska.'
        validates_type Integer, :Teacher_id, message: 'Nieprawidłowy typ danych dla nauczyciela'
        validates_length_range 2..50, :name, message: lambda{|s| "should be more than #{s} characters"}
        validates_unique :name
        errors.add(:Teacher_id, 'Teacher_id value is lower than 0') if self[:Teacher_id].to_i <= 0
        errors.add(:Teacher_id, 'Teacher does not exist') if Teacher[self[:Teacher_id].to_i] == nil
        validates_format /^[A-ZĄĆĘŁŃÓŚŹŻ]?[a-ząćęłńóśźż]+(([ ])[A-ZĄĆĘŁŃÓŚŹŻa-ząćęłńóśźż]+)*$/, :name, message: "contains invalid characters"

    end

    def self.printlabels
        puts " Nr |           Nazwa |             Nauczyciel "
        puts "----+-----------------+------------------------"
    end

    def printline(nr)
        printf("%3d |%16s |%23s\n" , nr+1 , name , self.Teacher.name + " " + self.Teacher.surname )
    end

    def cascadedelete
        self.StudentSubject.each do |n|
            n.cascadedelete
        end
        self.delete
    end

end


