class Grade

  attr_reader :grade_id, :grade, :category, :date, :student_id , :subject_id

  def initialize
    @grade_id = 0
    @grade = 0
    @category = ""
    @date = 0

    @student_id = 0
    @subject_id = 0
  end

end


