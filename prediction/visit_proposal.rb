class Prediction
  class VisitProposal
    def initialize(illness_request_id)
      @illness_request_id = illness_request_id
      @doctors = []
      @@attempt = 1
    end

    def run
      find_nearest_clinic_by_location
    end

    def run_s
      find_specializations_by_symptoms
    end

    def general_run
      find_doctors_in_clinics_by_specialization
    end

    # недостающие специализации
    def missing_specializations
      find_specializations_by_symptoms - general_specializations
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
    #   найти специализации по болезни
    #   найти ближайшую клинику
    #   посмотреть специализации клиники,
    #   если есть врачи нужных специализаций - сохранить их в @doctors
    #   если есть не занятые специализации, искать следующую клинику
    def find_doctors_in_clinics_by_specialization
      @all_specializations = find_specializations_by_symptoms if @@attempt == 1

      # получаем ближайшую клинику
      clinic = find_nearest_clinic_by_location[:clinic]

      unless @all_specializations.empty?
        # специализации, которые есть в клинике и в списке нужных
        general_specializations = @all_specializations & clinic_specializations(clinic)

        if !general_specializations.empty?
          # ищем врачей по специализациям, которые есть в клинике
          general_specializations.each do |spec|
            @doctors << Clinic.new(clinic[:id]).find_doctors_by_specialization(spec[:id])
          end

          # недостающие специализации(которых не оказалось в клинике)
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

    # получем массив специализаций клиники
    def clinic_specializations(clinic)
      Clinic.new(clinic[:id]).specializations
    end
  end
end
