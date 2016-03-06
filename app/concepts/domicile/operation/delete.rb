class Domicile::Delete < Trailblazer::Operation
  include Model
  model Domicile, :find

  def process(params)
    model.destroy
  end
end
