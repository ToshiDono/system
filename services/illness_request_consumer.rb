class Services
  class IllnessRequestConsumer
    include Hutch::Consumer
    consume 'illness.request.new'

    def process(message)
      puts message
      File.open("#{Dir.pwd}/hutch_logs.log", 'a') { |f| f.puts(message)}
    end
  end
end