class Event::Create < Trailblazer::Operation
  step Model(Event, :new)
  step Contract::Build(constant: Event::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()
end
