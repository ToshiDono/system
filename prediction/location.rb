class Prediction
  class Location
    # return {clinic}
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
          find_coordinates(Patient, illness_request_id),
          find_coordinates(Clinic, clinic_id),
          units: :km
      )
    end

    # return [coordinates]
    def find_coordinates(points_class, id)
      Geocoder.coordinates(points_class.new.address(id))
    end

    private

    def all_clinics
      @clinics ||= DB[:clinics].to_a
    end
  end
end
