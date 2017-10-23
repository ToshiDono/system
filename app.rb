require 'geocoder'
require_relative 'consumers/illness_request_consumer'
require_relative 'config/application'
require_relative 'prediction/patient'
require_relative 'prediction/clinic'
require_relative 'prediction/location'

IllnessRequestConsumer.new
