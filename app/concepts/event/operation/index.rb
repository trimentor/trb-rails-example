class Event::Index < Trailblazer::Operation
  step :model

  def model(options)
    options["model"] = Event.all
  end
end
