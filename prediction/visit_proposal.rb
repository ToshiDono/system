class Prediction
  class VisitProposal
    def initialize(illness_request_id)
      @illness_request_id = illness_request_id
      @doctors = []
    end

    def run
      find_nearest_clinic_by_location
    end

    def run_s
      find_specializations_by_symptoms
    end

    def generl_run
      find_doctor_in_clinic_by_specialization
    end

    # недостающие специализации
    def missing_specializations
      find_specializations_by_symptoms - general_specializations
    end

    # специализации, которые есть в клинике и в списке нужных
    def general_specializations
      # получаем ближайшую клинику
      clinic = find_nearest_clinic_by_location[:clinic]
      # получем массив специализаций клиники
      specializations = Clinic.new(clinic[:id]).specializations

      find_specializations_by_symptoms & specializations
    end

    private

    # return {clinic}
    def find_nearest_clinic_by_location
      @location ||= Prediction::Location.new
      @location.find_nearest_clinic(@illness_request_id)
    end

    # return [specialization]
    # находит специалиации врачей, которые могут вылечить болезни, по симптомам которые указал пациент
    def find_specializations_by_symptoms
      Specialization.new.find_by_illness_request(@illness_request_id)
    end

    # return [doctor]
    def find_doctor_in_clinic_by_specialization
    #   найти специализации по болезни - find_specializations_by_symptoms (вне клиник)
    #   найти ближайшую клинику
    #   посмотреть специализации клиники,
    #   если есть врачи нужных специализаций - сохранить их в @doctors
    #   если есть не занятые специализации, искать следующую клинику

      @all_specializations = if @all_specializations.nil?
                               find_specializations_by_symptoms
                             else
                               find_specializations_by_symptoms - @all_specializations
                             end
      puts 'специалиации врачей, которые могут вылечить болезни, по симптомам которые указал пациент:'
      puts @all_specializations

      # получаем ближайшую клинику
      puts 'ближайшая клиника:'
      clinic = find_nearest_clinic_by_location[:clinic]
      puts clinic
      # получем массив специализаций клиники
      puts 'массив специализаций клиники:'
      clinic_specializations = Clinic.new(clinic[:id]).specializations
      puts clinic_specializations

      unless @all_specializations.nil?
        # специализации, которые есть в клинике и в списке нужных
        puts 'специализации, которые есть в клинике и в списке нужных:'
        general_specializations = @all_specializations & clinic_specializations
        puts general_specializations

        # ищем врачей по специализациям, которые есть в клинике
        general_specializations.each do |spec|
          @doctors << Clinic.new(clinic[:id]).find_doctors_by_specialization(spec[:id])
        end

        # недостающие специализации(которых не оказалось в клинике)
        missing_specializations = @all_specializations - general_specializations

        if missing_specializations
          @location.exclude_clinics_ids << clinic[:id]
          find_doctor_in_clinic_by_specialization
        end
      end

      @doctors
    end
  end
end
