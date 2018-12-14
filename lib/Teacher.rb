class Teacher

    attr_reader :id, :name, :surname

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

    def gethash
        data = Hash.new
        data[:id] = @id
        data[:name] = @name
        data[:surname] = @surname
        data
    end

end


