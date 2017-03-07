class Domicile::Update < Domicile::Create
  step Model(Domicile, :find), override: true
  step Contract::Build(constant: Domicile::Contract::Update), override: true
end
