class Person::Create < Trailblazer::Operation
  step Model(Person, :new)
  step Contract::Build(constant: Person::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()
end
