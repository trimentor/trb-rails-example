class Phone::Create < Trailblazer::Operation
  extend Contract::DSL

  # TODO: Implement Phonelib to validate the telephone numbers.
  # https://github.com/daddyz/phonelib
  contract do
    property :person_id
    property :telephone_number
    property :telephone_type
    property :category
  
    validates :person_id, presence: true
    validates :telephone_number, presence: true
    validates :telephone_type, inclusion: {in: Phone.telephone_types.values}
    validates :category, inclusion: {in: Phone.categories.values}
  end

  step Model(Phone, :new)
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()
end
