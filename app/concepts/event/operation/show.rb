class Event::Show < Trailblazer::Operation
  include Model
  model Event, :find

  def process(params)
  end
end
