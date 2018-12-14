class Student

    attr_accessor :id, :name, :surname

    def initialize
        @id = 0
        @name = ""
        @surname = ""
    end

    def sethash(data)
        @id = data[:id]
        @name = data[:name]
        @surname  = data[:surname]
        self
    end

    def setarray(data)
        @id = data[0]
        @name = data[1]
        @surname  = data[2]
        self
    end

    def gethash
        data = Hash.new
        data[:id] = @id
        data[:name] = @name
        data[:surname] = @surname
        data
    end

    def getarray
        data = Array.new
        data[0] = @id
        data[1] = @name
        data[2] = @surname
        data
    end

end