class Clinic < Base
  attr_reader :essence

  def initialize(id)
    @essence = find_on_id(id)
  end

  # return string
  def address
    essence[:address]
  end

  # return [{doctor}]
  def find_doctors_by_specialization(specialization_id)
    DB[
        'SELECT * FROM doctors
         INNER JOIN practices
         ON (doctors.id = practices.doctor_id)
         INNER JOIN clinics
         ON (practices.clinic_id = clinics.id)
         INNER JOIN doctor_specializations
         ON (doctors.id = doctor_specializations.doctor_id)
         WHERE clinics.id = ?
         AND doctor_specializations.specialization_id = ?', essence[:id], specialization_id
    ]
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
