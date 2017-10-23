class Prediction
  class Clinic

    # return [clinics coordinates]
    def find_coordinates(clinic_id)
      Geocoder.coordinates(self.address(clinic_id))
    end

    # return string
    def address(clinic_id)
      DB['SELECT address FROM clinics WHERE(id=?)', clinic_id].first[:address]
    end
  end
end
