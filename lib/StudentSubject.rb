class StudentSubject < Sequel::Model(Database.db[:StudentSubject])

    plugin :validation_helpers
    one_to_many :Grade
    many_to_one :Student
    many_to_one :Subject

    def validate
        validates_presence [:Student_id,:Subject_id], message: 'Nie podano wszystkich niezbędnych danych.'
        validates_type Integer, [:Student_id,:Subject_id], message: 'Nieprawidłowy typ danych.'
        errors.add(:Student_id, 'Błędne przypisanie dla studenta!') if self[:Student_id].to_i <= 0
        errors.add(:Subject_id, 'Błędne przypisanie dla przedmiotu!') if self[:Subject_id].to_i <= 0
        errors.add(:Student_id, 'Dany student nie istnieje!') if Student[self[:Student_id].to_i].nil?
        errors.add(:Subject_id, 'Dany przedmiot nie istnieje!') if Subject[self[:Subject_id].to_i].nil?
        validates_unique([:Student_id,:Subject_id], message: 'Uczeń jest już przypisany do tego przedmiotu.')
    end

    def self.printlabels
        puts " Nr |           Nazwa |             Nauczyciel "
        puts "----+-----------------+------------------------"
    end

    def printline(nr)
        self.Subject.printline(nr)
    end

end