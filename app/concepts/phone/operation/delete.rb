class Phone::Delete < Trailblazer::Operation
  include Model
  model Phone, :find

  def process(params)
    model.destroy
  end
end
