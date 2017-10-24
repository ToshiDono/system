class Prediction
  class VisitProposal
    def initialize(illness_request_id)
      @illness_request_id = illness_request_id
    end

    def run
      find_by_location
    end

    def run_s
      find_by_symptom
    end

    private

    # return {clinic}
    def find_by_location
      Prediction::Location.new.find_nearest_clinic(@illness_request_id)
    end

    def find_by_symptom
      Specialization.new.find_by_illness_request(@illness_request_id)
    end
  end
end
