class Domicile::Create < Trailblazer::Operation
  step Model(Domicile, :new)
  step Contract::Build(constant: Domicile::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()
end
