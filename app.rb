require 'geocoder'
require_relative 'config/application'
require_relative 'consumers/illness_request_consumer'
require_relative 'models/base'
require_relative 'models/patient'
require_relative 'models/clinic'
require_relative 'models/specialization'
require_relative 'prediction/location'
require_relative 'prediction/visit_proposal'

IllnessRequestConsumer.new
