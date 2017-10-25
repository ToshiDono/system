class Patient < Base
  attr_reader :essence

  def initialize(id)
    @essence = find_on_id(id)
  end

  # return patients.id
  def self.find_on_illness_request_id(id)
    DB
        .from(:patients)
        .join(:illness_requests, patient_id: :id)
        .where(Sequel.lit('illness_requests.id=?', id))
        .select(Sequel.lit('patients.id')).first[:id]
  end

  # return string
  def address
    essence[:address]
  end

  private

  # return {patient}
  def find_on_id(id)
    DB.from(:patients).where(id: id).first
  end
end
