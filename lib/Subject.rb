class Subject < Sequel::Model(Database.db[:Subject])

    plugin :validation_helpers
    many_to_one :Teacher
    one_to_many :StudentSubject

    def validate
        super
        validates_presence [:name,:Teacher_id], message: 'was not given'
        validates_type String , :name, message: 'wrong value type'
        validates_type Integer, :Teacher_id, message: 'wrong value type'
        validates_length_range 3..50, :name, message: lambda{|s| "should be more than #{s} characters"}
        errors.add(:Teacher_id, 'Teacher_id value is lower than 0') if self[:Teacher_id].to_i <= 0
        validates_format /^[A-ZĄĆĘŁŃÓŚŹŻ][a-ząćęłńóśźż]+(([ ])[A-ZĄĆĘŁŃÓŚŹŻa-ząćęłńóśźż]+)*$/, :name, message: "contains invalid characters"

    end

    def self.printlabels
        puts " Nr |        Nazwa |             Nauczyciel "
        puts "----+--------------+------------------------"
    end

    def printline(nr)
        printf("%3d |%13s |%23s\n" , nr+1 , name , self.Teacher.name + " " + self.Teacher.surname )
    end

end


