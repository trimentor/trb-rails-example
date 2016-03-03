class Phone::Update < Trailblazer::Operation
  include Model
  model Phone, :update

  # TODO: Implement Phonelib to validate the telephone numbers.
  # https://github.com/daddyz/phonelib
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
