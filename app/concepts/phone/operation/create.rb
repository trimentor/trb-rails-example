class Phone::Create < Trailblazer::Operation
  include Model
  model Phone, :create

  contract do
    property :person_id, validates: {presence: true}
    property :telephone_number, validates: {presence: true}
    property :telephone_type, validates: {inclusion: {in: Phone.telephone_types.values}}
    property :category, validates: {inclusion: {in: Phone.categories.values}}
  end

  def process(params)
    validate(params[:phone], @model) do
      contract.save
    end
  end
end
