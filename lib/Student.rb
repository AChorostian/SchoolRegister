class Student

    attr_accessor :id, :name, :surname

    def initialize
        @id = nil
        @name = ""
        @surname = ""
    end

    def sethash(data)
        @id = data[:id]
        @name = data[:name]
        @surname  = data[:surname]
        self
    end

    def gethash
        data = Hash.new
        data[:id] = @id
        data[:name] = @name
        data[:surname] = @surname
        data
    end

    def self.printlabels
        puts " Nr |        Imię |     Nazwisko "
        puts "----+-------------+--------------"
    end

    def printline(nr)
        printf("%3d |%12s |%13s\n" , nr , @name , @surname )
    end

end