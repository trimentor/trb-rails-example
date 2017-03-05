class Domicile::Create < Trailblazer::Operation
  extend Contract::DSL

  contract do
    property :person_id
    property :address_id

    validates :person_id, presence: true
    validates :address_id, presence: true

    validate :can_only_have_one_domicile

    def can_only_have_one_domicile
      if !Domicile.where(person_id: person_id).empty?
        errors.add(:person_id, 'can only have one domicile')
      end
    end
  end

  step Model(Domicile, :new)
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()
end
