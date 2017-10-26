class Specialization
  # return [doctors specializations]
  def find_by_illness_request(id)
    DB[
    'SELECT specializations.id, specializations.title, specializations.code
	    FROM public.specializations
      INNER JOIN disease_specializations
      ON specializations.id = disease_specializations.specialization_id
      INNER JOIN disease_symptoms
      ON disease_specializations.disease_id = disease_symptoms.disease_id
      INNER JOIN illness_request_symptoms
      ON disease_symptoms.symptom_id = illness_request_symptoms.symptom_id
      WHERE (illness_request_symptoms.illness_request_id = ?)
      ORDER BY id ASC', id
    ].all
  end
end
