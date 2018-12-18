class Student < Sequel::Model(Database.db[:Student])

    plugin :validation_helpers
    one_to_many :StudentSubject
    one_to_many :Note


    def validate
        super
        validates_presence [:name,:surname], message: 'was not given'
        validates_type String, [:name, :surname], message: 'wrong value type'
        validates_length_range 3..50, [:name,:surname], message: lambda{|s| "should be more than #{s} characters"}
        validates_format /^([ \u00c0-\u01ffa-zA-Z'\-])+$/, [:name,:surname], message: "contains invalid characters"
    end

    def self.plist
        Student.to_a.map.each do |i|
            i.to_hash[:id].to_s + " " + i.to_hash[:name].to_s
        end
    end



    def self.printlabels
        puts " Nr |        Imię |     Nazwisko "
        puts "----+-------------+--------------"
    end

    def printline(nr)
        printf("%3d |%12s |%13s\n" , nr , @name , @surname )
    end

end



#<Sequel::SQLite::Dataset:0x00007fa37c8dbc20>