class Address::Create < Trailblazer::Operation
  step Model(Address, :new)
  step Contract::Build(constant: Address::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()
end
