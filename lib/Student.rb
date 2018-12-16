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



end