class Event::Delete < Trailblazer::Operation
  include Model
  model Event, :find

  def process(params)
    model.destroy
  end
end
