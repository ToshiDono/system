require_relative 'services/illness_request_creator'
require_relative 'services/illness_request_consumer'

consumer = Services::IllnessRequestConsumer.new
# создается только 1 сообщение
Services::IllnessRequestCreator.new
Services::IllnessRequestCreator.new
Services::IllnessRequestCreator.new
Services::IllnessRequestCreator.new
Services::IllnessRequestCreator.new