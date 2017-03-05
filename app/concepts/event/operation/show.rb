class Event::Show < Trailblazer::Operation
  step Model(Event, :find)
end
