class Email::Show < Trailblazer::Operation
  include Model
  model Email, :find

  def process(params)
  end
end
