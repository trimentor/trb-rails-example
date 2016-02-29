class Event::Index < Trailblazer::Operation
  def process(params)
    @model = Event.all
  end
end
