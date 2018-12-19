require 'sequel'
class Grade < Sequel::Model(Database.db[:Grade])

    plugin :validation_helpers
    many_to_one :StudentSubject

    def validate
        validates_presence [:grade, :comment, :date], message: 'was not given'
        validates_includes [1,2,3,4,5,6], :grade, message: 'wrong grade given [1..6] allowed'
        validates_type Integer, :grade, message: 'wrong value type'
        validates_type String, [:comment, :date], message: 'wrong value type'

        validates_format /^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$/, :date, message: "invalid date format"
        validates_length_range 3..500, :comment, message: lambda{|s| "should be more than #{s} characters"}
        errors.add(:StudentSubject_id, 'StudentSubject_id value is lower than 0') if self[:StudentSubject_id].to_i <= 0
        errors.add(:StudentSubject_id, 'StudentSubject does not exist') if StudentSubject[self[:StudentSubject_id].to_i] == nil

    end

    def self.printlabels
        puts " Nr | Ocena |       Komentarz |       Data "
        puts "----+-------+-----------------+------------"
    end

    def printline(nr)
        printf("%3d |%6s |%16s |%11s\n" , nr+1 , grade.to_s , comment.to_s , date.to_s)
    end

end
