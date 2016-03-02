class Email::Update < Trailblazer::Operation
  include Model
  model Email, :update

  contract do
    property :person_id, validates: {presence: true}
    property :address, validates: {presence: true}
    property :category, validates: {inclusion: {in: Email.categories.values}}
  end

  def process(params)
    validate(params[:email], @model) do
      contract.save
    end
  end
end
