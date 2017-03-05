class Email::Create < Trailblazer::Operation
  extend Contract::DSL

  contract do
    property :person_id
    property :address
    property :category

    validates :person_id, presence: true
    validates :address, presence: true
    validates :category, inclusion: {in: Email.categories.values}
  end

  step Model(Email, :new)
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()
end
