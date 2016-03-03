class Phone::Show < Trailblazer::Operation
  include Model
  model Phone, :find

  def process(params)
  end
end
