class Teacher

  attr_reader :teacher_id, :name, :surname, :subjects

  def initialize
    @teacher_id = 0
    @name = ""
    @surname = ""
    @subjects = Array.new
  end

end


