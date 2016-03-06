class Email::Create < Trailblazer::Operation
  include Model
  model Email, :create

  contract do
    property :person_id
    property :address
    property :category

    validates :person_id, presence: true
    validates :address, presence: true
    validates :category, inclusion: {in: Email.categories.values}
  end

  def process(params)
    validate(params[:email], @model) do
      contract.save
    end
  end
end
