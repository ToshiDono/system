class Prediction
  class Location
    # return { distance: X, clinic: {} }
    def find_nearest_clinic(illness_request_id)
      all_clinics.reduce({ distance: distance(illness_request_id, 1), clinic: all_clinics.first }) do |result, clinic|
        current_distance = distance(illness_request_id, clinic[:id])
        result.merge!(distance: current_distance, clinic: clinic) if result[:distance] > current_distance
        result
      end
    end

    # return km
    def distance(illness_request_id, clinic_id)
      Geocoder::Calculations.distance_between(
          find_coordinates(Patient, Patient.find_on_illness_request_id(illness_request_id)),
          find_coordinates(Clinic, clinic_id),
          units: :km
      )
    end

    # return [coordinates]
    def find_coordinates(points_class, id)
      return points_coordinates(points_class, id) if coordinates_exists?(points_class, id)
      Geocoder.coordinates(points_class.new(id).address)
    end

    # return boolean
    def coordinates_exists?(points_class, id)
      points_coordinates(points_class, id).has_value?(!nil)
    end

    private

    # return [clinics]
    def all_clinics
      @clinics ||= DB[:clinics].to_a
    end

    # return { latitude: x, longitude: x }
    def points_coordinates(points_class, id)
      DB[
          "SELECT latitude, longitude FROM #{points_class.to_s.downcase}s
          WHERE id=?", id
      ].first
    end
  end
end
