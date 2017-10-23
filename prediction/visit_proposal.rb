class Prediction
  class VisitProposal

    def initialize(illness_request_id)
      @illness_request_id = illness_request_id
    end

    def run
      find_by_location
    end

    private

    # return {clinic}
    def find_by_location
      Prediction::Location.new.find_nearest_clinic(@illness_request_id)
    end
    #
  end
end