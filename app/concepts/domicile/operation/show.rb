class Domicile::Show < Trailblazer::Operation
  step Model(Domicile, :find)
end
