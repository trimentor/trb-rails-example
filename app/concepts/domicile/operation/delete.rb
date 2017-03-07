class Domicile::Delete < Trailblazer::Operation
  step Model(Domicile, :find)
  step -> (options) { options["model"].destroy }
end
