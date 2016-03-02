class Birthday::Delete < Trailblazer::Operation
  include Model
  model Birthday, :find

  def process(params)
    model.destroy
  end
end
