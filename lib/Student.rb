class Student < Sequel::Model(Database.db[:Student])

    def self.printlabels
        puts " Nr |        Imię |     Nazwisko "
        puts "----+-------------+--------------"
    end

    def printline(nr)
        printf("%3d |%12s |%13s\n" , nr , @name , @surname )
    end

end