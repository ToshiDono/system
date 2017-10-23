class Clinic

  # return string
  def address(clinic_id)
    DB['SELECT address FROM clinics WHERE(id=?)', clinic_id].first[:address]
  end
end
