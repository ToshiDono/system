require 'geocoder'
require_relative 'consumers/illness_request_consumer'
require_relative 'config/application'
require_relative 'models/base'
require_relative 'models/patient'
require_relative 'models/clinic'
require_relative 'prediction/visit_proposal'
require_relative 'prediction/location'

IllnessRequestConsumer.new
