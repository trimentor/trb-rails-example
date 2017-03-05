class Domicile::Show < Trailblazer::Operation
  extend Contract::DSL

  step Model(Domicile, :find)
end
