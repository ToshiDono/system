class Services
  class IllnessRequestCreator
    Hutch.connect
    Hutch.publish('illness.request.new', subject: 'new illness_request')
  end
end

