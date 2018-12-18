class StudentSubject < Sequel::Model(Database.db[:StudentSubject])

    plugin :validation_helpers
    one_to_many :Grade
    many_to_one :Student
    many_to_one :Subject

    def validate
        validates_presence [:Student_id,:Subject_id], message: 'was not given'
        validates_type Integer, [:Student_id,:Subject_id], message: 'wrong value type'
        errors.add(:Student_id, 'Student_id value is lower than 0') if self[:Student_id] <= 0
        errors.add(:Subject_id, 'Subject_id value is lower than 0') if self[:Subject_id] <= 0
        validates_unique(:Student_id,:Subject_id)
    end

    def self.printlabels
        puts " Nr |        Nazwa |             Nauczyciel "
        puts "----+--------------+------------------------"
    end

    def printline(nr)
        self.Subject.printline(nr)
    end

end