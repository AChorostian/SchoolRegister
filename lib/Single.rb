class Single

    def self.Student(id)
        Menu.top
        Student.printlabels
        Student.where(id: id).first.printline(id)

        print "podaj nr: "
        input = gets.to_i
        if input != 0
            #selected(cl,input)
        end
    end

end