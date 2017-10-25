class Patient < Base
  attr_reader :essence

  def initialize(id)
    @essence = find_on_id(id)
  end

  # return patients.id
  def self.find_on_illness_request_id(id)
    DB[
        'SELECT patients.id FROM patients
         INNER JOIN illness_requests
         ON (illness_requests.patient_id=patients.id)
         WHERE(illness_requests.id=?)', id
    ].first[:id]
  end

  # return string
  def address
    essence[:address]
  end

  private

  # return {patient}
  def find_on_id(id)
    DB[
        'SELECT * FROM patients
         WHERE (id=?)', id
    ].first
  end
end
