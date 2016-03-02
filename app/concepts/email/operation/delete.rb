class Email::Delete < Trailblazer::Operation
  include Model
  model Email, :find

  def process(params)
    model.destroy
  end
end
