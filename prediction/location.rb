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
          self.find_coordinates(Patient,illness_request_id),
          self.find_coordinates(Clinic, clinic_id),
          units: :km
      )
    end

    # return [coordinates]
    def find_coordinates(points_class, id)
      Geocoder.coordinates(points_class.new.address(id))
    end

    private

    def all_clinics
      DB[:clinics].to_a
    end
  end
end
