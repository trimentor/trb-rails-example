class Domicile::Delete < Trailblazer::Operation
  extend Contract::DSL

  step Model(Domicile, :find)
  step -> (options) { options["model"].destroy }
end
