class Phone::Create < Trailblazer::Operation
  step Model(Phone, :new)
  step Contract::Build(constant: Phone::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()
end
