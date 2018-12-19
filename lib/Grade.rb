require 'sequel'
class Grade < Sequel::Model(Database.db[:Grade])

    plugin :validation_helpers
    many_to_one :StudentSubject

    def validate
        validates_presence [:grade, :comment, :date], message: 'was not given'
        validates_includes [1,2,3,4,5,6], :grade, message: 'wrong grade given [1..6] allowed'
        validates_type Integer, :grade, message: 'wrong value type'
        validates_type String, [:comment, :date], message: 'wrong value type'
        validates_length_range 3..500, :comment, message: lambda{|s| "should be more than #{s} characters"}
        errors.add(:StudentSubject_id, 'StudentSubject_id value is lower than 0') if self[:StudentSubject_id] <= 0
    end

    def self.printlabels
        puts " Nr | Ocena |       Komentarz |       Data "
        puts "----+-------+-----------------+------------"
    end

    def printline(nr)
        printf("%3d |%6s |%16s |%11s\n" , nr , grade.to_s , comment.to_s , date.to_s)
    end

end
