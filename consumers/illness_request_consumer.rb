class IllnessRequestConsumer
  include Hutch::Consumer
  consume 'illness.request.new'

  def process(message)
    visit_proposal = Prediction::VisitProposal.new(message.body['subject']).run
    report = "Create IllnessRequest with id = #{message.body['subject']}. Future visit: #{visit_proposal}"
    File.open("#{Dir.pwd}/hutch_logs.log", 'a') { |f| f.puts(report)}
  end
end
