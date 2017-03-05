class ContactManager::Create < Trailblazer::Operation
  def process(params)
    validate(params[:contact_manager]) do
      person_params = params[:contact_manager].fetch(:person)
      person_operation = Person::Create.(person: person_params)

      address_pa
    end
  end
end
