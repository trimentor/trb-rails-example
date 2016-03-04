class Address::Show < Trailblazer::Operation
  include Model
  model Address, :find

  def process(params)
  end
end
