class Student < Sequel::Model(Database.db[:Student])

    plugin :validation_helpers
    one_to_many :StudentSubject
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

    def count_subjects
        self.StudentSubject.length
    end

    def count_grades
        self.StudentSubject.sum(&:count_grades)
    end

    def count_notes
        self.Note.length
    end

    def average_average_grades
        self.StudentSubject.sum(&:average_grades).to_f / self.count_subjects.to_f
    end

    def average_grades
        self.StudentSubject.sum(&:sum_grades).to_f / self.count_grades.to_f
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

    def fullname
        name.to_s + " " + surname.to_s
    end

end


