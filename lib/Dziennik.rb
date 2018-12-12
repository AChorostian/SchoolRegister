require_relative 'Uczen.rb'
require_relative 'Database.rb'

class Dziennik
    attr_reader :uczniowie
    def initialize
        @uczniowie = [
            { imie: "Jan", nazwisko: "Kowalski", przedmioty: [
                    { nazwa: "matma", nauczyciel: "pan Wojtek", oceny: [
                            { ocena: 3 , opis: "kartkowka" , data: Date.new(2017,12,3) },
                            { ocena: 4 , opis: "sprawdzian" , data: Date.new(2018,11,5) },
                            { ocena: 5 , opis: "aktywnosc" , data: Date.new(2018,1,7) }
                        ] },
                    { nazwa: "polski", nauczyciel: "pani Justyna", oceny: [] },
                ] , uwagi: [
                    { tresc: "Jasiu byl niegrzeczny" , data: Date.new(2017,12,3) , nauczyciel: "pani Grazyna" },
                    { tresc: "Jasiu znowu byl niegrzeczny" , data: Date.new(2017,12,13) , nauczyciel: "pani Grazyna" }
                ] },
            { imie: "Tomasz", nazwisko: "Nowak", przedmioty: [] },
            { imie: "Piotr", nazwisko: "Wiśniewski", przedmioty: [] },
            { imie: "Joanna", nazwisko: "Kowalczyk", przedmioty: [] }
        ]
    end
end
