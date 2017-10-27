class Prediction
  class Location
    attr_accessor :exclude_clinics_ids

    def initialize
      @exclude_clinics_ids = []
    end

    # return { distance: X, clinic: {} }
    def find_nearest_clinic(illness_request_id)
      clinics.reduce({ distance: distance(illness_request_id, 1), clinic: clinics.first }) do |result, clinic|
        current_distance = distance(illness_request_id, clinic[:id])
        result.merge!(distance: current_distance, clinic: clinic) if result[:distance] > current_distance
        result
      end
    end

    # return km
    def distance(illness_request_id, clinic_id)
      dist = Geocoder::Calculations.distance_between(
          find_coordinates(Patient, Patient.find_on_illness_request_id(illness_request_id)),
          find_coordinates(Clinic, clinic_id),
          units: :km
      )
      dist.nil? ? distance(illness_request_id, clinic_id) : dist
    end

    # return [coordinates]
    def find_coordinates(points_class, id)
      coord = points_coordinates(points_class, id)
      return coord if coord.has_value?(!nil)
      geo_coord = Geocoder.coordinates(points_class.new(id).address)
      geo_coord.nil? ? find_coordinates(points_class, id) : geo_coord
    end

    private

    # return Sequel::Postgres::Dataset
    def all_clinics
      @clinics ||= DB[:clinics]

    end

    # return [clinics]
    def clinics
      if @exclude_clinics_ids
        clinics_exclude
      else
        all_clinics.to_a
      end
    end

    # return [clinics]
    def clinics_exclude
      all_clinics.exclude(id: @exclude_clinics_ids).to_a
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
