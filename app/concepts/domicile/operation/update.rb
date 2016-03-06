class Domicile::Update < Domicile::Create
  action :update

  contract do
    def can_only_have_one_domicile
      # Overwrite validation defined in Domicile::Create.
      # Do nothing.
    end
  end
end
