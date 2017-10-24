class Clinic < Base
  attr_reader :essence

  def initialize(id)
    @essence = find_on_id(id)
  end

  # return string
  def address
    essence[:address]
  end

  private

  # return {clinic}
  def find_on_id(id)
    DB[
        'SELECT * FROM clinics
         WHERE (id=?)', id
    ].first
  end
end
