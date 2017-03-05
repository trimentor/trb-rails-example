class Event::Delete < Trailblazer::Operation
  step Model(Event, :find)
  step -> (options) { options["model"].destroy }
end
