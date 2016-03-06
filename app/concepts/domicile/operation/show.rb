class Domicile::Show < Trailblazer::Operation
  include Model
  model Domicile, :find

  def process(params)
  end
end
