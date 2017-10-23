class Prediction
  class Location

    # return {clinic}
    def find_nearest_clinic(illness_request_id)
      clinics = all_clinics
      result = {distance: distance(illness_request_id, 1), clinic: clinics.first}
      clinics.each do |clinic|
        current_distance = distance(illness_request_id, clinic[:id])
        if result[:distance] > current_distance
          result[:distance] = current_distance
          result[:clinic] = clinic
        end
      end
      result[:clinic]
    end

    # return km
    def distance(illness_request_id, clinic_id)
      Geocoder::Calculations.distance_between(
          Prediction::Patient.new.find_coordinates(illness_request_id),
          Prediction::Clinic.new.find_coordinates(clinic_id),
          units: :km
      )
    end

    # return [patients coordinates]
    def find_patient_coordinates(illness_request_id)
      Prediction::Patient.new.find_coordinates(illness_request_id)
    end

    # return [clinics coordinates]
    def find_clinic_coordinates(clinic_id)
      Prediction::Clinic.new.find_coordinates(clinic_id)
    end

    private

    def all_clinics
      DB[:clinics].to_a
    end
  end
end
