class Prediction
  class VisitProposal
    def initialize(illness_request_id)
      @illness_request_id = illness_request_id
      @doctors = []
      @@attempt = 1
    end

    def run
      find_doctors_in_clinics_by_specialization
    end

    private

    # return {clinic}
    def find_nearest_clinic_by_location
      @location ||= Prediction::Location.new
      @location.find_nearest_clinic(@illness_request_id)
    end

    # return [specialization]
    def find_specializations_by_symptoms
      Specialization.new.find_by_illness_request(@illness_request_id)
    end

    # return [doctor]
    def find_doctors_in_clinics_by_specialization
      @all_specializations = find_specializations_by_symptoms if @@attempt == 1

      clinic = find_nearest_clinic_by_location[:clinic]

      unless @all_specializations.empty?
        # specialization, which are in the clinic and in the list of relevant
        general_specializations = @all_specializations & clinic_specializations(clinic)

        if !general_specializations.empty?
          # looking for doctors in the specializations that are in the clinic
          general_specializations.each do |spec|
            @doctors << Clinic.new(clinic[:id]).find_doctors_by_specialization(spec[:id])
          end

          # missing specializations (which were not in the clinic)
          @all_specializations -= general_specializations

          search_repeat(clinic) unless @all_specializations.empty?
        else
          search_repeat(clinic)
        end
      end
      @doctors
    end

    # return [{ doctors }]
    def search_repeat(clinic)
      @location.exclude_clinics_ids << clinic[:id]
      @@attempt += 1
      find_doctors_in_clinics_by_specialization
    end

    # return [specialization]
    def clinic_specializations(clinic)
      Clinic.new(clinic[:id]).specializations
    end
  end
end
