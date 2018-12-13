class Note

  attr_reader :note_id, :description, :date, :student_id, :teacher_id

  def initialize
    @note_id = 0
    @description = ""
    @date = 0

    @student_id = 0
    @teacher_id = 0
  end

end


