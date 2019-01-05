class Subject < Sequel::Model(Database.db[:Subject])

    plugin :validation_helpers
    many_to_one :Teacher
    one_to_many :StudentSubject

    def validate
        super
        validates_presence [:name,:Teacher_id], message: 'Nie podano wszystkich niezbędnych danych.'
        validates_type String , :name, message: 'Nieprawidłowy typ danych dla nazwy przedmiotu.'
        validates_type Integer, :Teacher_id, message: 'Nieprawidłowy typ danych dla nauczyciela'
        validates_length_range 2..50, :name, message: lambda{|s| "Imie powinno mieć więcej niż #{s} znaków"}
        validates_unique :name, message: 'Przedmiot o takiej nazwie już istnieje.'
        errors.add(:Teacher_id, 'Błędne przypisanie dla nauczyciela!') if self[:Teacher_id].to_i <= 0
        errors.add(:Teacher_id, 'Dany nauczyciel nie istnieje!') if Teacher[self[:Teacher_id].to_i] == nil
        validates_format /^[A-ZĄĆĘŁŃÓŚŹŻ]?[a-ząćęłńóśźż]+(([ ])[A-ZĄĆĘŁŃÓŚŹŻa-ząćęłńóśźż]+)*$/, :name, message:
        "Błędny format nazwy"

    end

    def self.printlabels
        puts " Nr |           Nazwa |             Nauczyciel "
        puts "----+-----------------+------------------------"
    end

    def printline(nr)
        printf("%3d |%16s |%23s\n" , nr+1 , name , self.Teacher.name + " " + self.Teacher.surname )
    end

    def count_students
        self.StudentSubject.count
    end

    def count_grades
        self.StudentSubject.sum(&:count_grades)
    end

    def sum_grades
        self.StudentSubject.sum(&:sum_grades)
    end

    def average_average_grades
        self.StudentSubject.sum(&:average_grades).to_f / self.count_students.to_f
    end

    def average_grades
        self.StudentSubject.sum(&:sum_grades).to_f / self.count_grades.to_f
    end

    def average_count_grades
        self.StudentSubject.sum(&:count_grades).to_f / self.count_students.to_f
    end

    def max_average_grades
        self.StudentSubject.max_by(&:average_grades)
    end

    def min_average_grades
        self.StudentSubject.min_by{ |ss| ss.average_grades unless ss.average_grades==0 }
    end

    def max_count_grades
        self.StudentSubject.max_by(&:count_grades)
    end

    def min_count_grades
        self.StudentSubject.min_by(&:count_grades)
    end

end


