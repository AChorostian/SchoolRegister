class Ocena

  attr_reader :ocena_id, :ocena, :kategoria, :data, :uczen_id , :przedmiot_id

  def initialize
    @ocena_id = 0
    @ocena = 0
    @kategoria = ""
    @data = 0

    @uczen_id = 0
    @przedmiot_id = 0
  end

end


