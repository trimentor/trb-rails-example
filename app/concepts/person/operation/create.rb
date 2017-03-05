class Person::Create < Trailblazer::Operation
  extend Contract::DSL

  contract do
    property :first_name
    property :middle_name
    property :last_name

    validates :first_name, presence: true
  end

  step Model(Person, :new)
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()
end
