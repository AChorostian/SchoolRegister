require_relative 'Student.rb'
require_relative 'Database.rb'

class Register
    attr_reader :students
    def initialize
        @students = [
            {name: "Jan", surname: "Kowalski", przedmioty: [
                    {name: "matma", nauczyciel: "pan Wojtek", oceny: [
                            {grade: 3 , opis: "kartkowka" , date: Date.new(2017, 12, 3) },
                            {grade: 4 , opis: "sprawdzian" , date: Date.new(2018, 11, 5) },
                            {grade: 5 , opis: "aktywnosc" , date: Date.new(2018, 1, 7) }
                        ] },
                    {name: "polski", nauczyciel: "pani Justyna", oceny: [] },
                ] , uwagi: [
                    {description: "Jasiu byl niegrzeczny" , date: Date.new(2017, 12, 3) , nauczyciel: "pani Grazyna" },
                    {description: "Jasiu znowu byl niegrzeczny" , date: Date.new(2017, 12, 13) , nauczyciel: "pani Grazyna" }
                ] },
            {name: "Tomasz", surname: "Nowak", przedmioty: [] },
            {name: "Piotr", surname: "Wiśniewski", przedmioty: [] },
            {name: "Joanna", surname: "Kowalczyk", przedmioty: [] }
        ]
    end
end
