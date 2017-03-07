class Email::Create < Trailblazer::Operation
  step Model(Email, :new)
  step Contract::Build(constant: Email::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()
end
