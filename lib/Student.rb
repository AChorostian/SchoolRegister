class Student

    attr_reader :id, :name, :surname, :subjects

    def initialize(n,s)
        @id = 0
        @name = n
        @surname = s
        @subjects = Array.new
    end

    def setid(i)
        @id = i
    end

end


