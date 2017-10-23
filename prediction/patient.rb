class Prediction
  class Patient

    # return [patients coordinates]
    def find_coordinates(illness_request_id)
      Geocoder.coordinates(self.address(illness_request_id))
    end

    # return string
    def address(illness_request_id)
      DB['SELECT address FROM patients INNER JOIN illness_requests ON (illness_requests.patient_id=patients.id) WHERE(illness_requests.id=?)', illness_request_id].first[:address]
    end
  end
end
