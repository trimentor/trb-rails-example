class Address::Delete < Trailblazer::Operation
  include Model
  model Address, :find

  def process(params)
    model.destroy
  end
end
