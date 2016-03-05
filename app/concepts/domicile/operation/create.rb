class Domicile::Create < Trailblazer::Operation
  include Model
  model Domicile, :create

  contract do
    property :person_id,  validates: {presence: true}
    property :address_id, validates: {presence: true}

    validate :can_only_have_one_domicile

    def can_only_have_one_domicile
      if !Domicile.where(person_id: person_id).empty?
        errors.add(:person_id, 'can only have one domicile')
      end
    end
  end

  def process(params)
    validate(params[:domicile], @model) do
      contract.save
    end
  end
end
