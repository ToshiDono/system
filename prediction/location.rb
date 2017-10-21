# require_relative '../config/application'
require '../config/application'

class Prediction
  class Location

    def find_patient_location#(illness_request_id)
      # в illness_requests по illness_request_id найти пациента и у него адрес(вернуть адрес)
      DB[:illness_requests]
    end
  end
end

a = Prediction::Location.new
a.find_patient_location.each do |ir|
  puts ir.inspect
end
