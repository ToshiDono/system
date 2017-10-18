class Services
  class IllnessRequestConsumer
    include Hutch::Consumer
    consume 'illness.request.new'

    # to-do
    # нужно будет забрать IllnessRequest по id(в сообщении) из базы и обработать другими классами
    def process(message)
      File.open("#{Dir.pwd}/hutch_logs.log", 'a') { |f| f.puts("Create IllnessRequest with id = #{message.body['subject']}")}
    end
  end
end