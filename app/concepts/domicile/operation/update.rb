class Domicile::Update < Trailblazer::Operation
  include Model
  model Domicile, :update

  contract do
    property :person_id,  validates: {presence: true}
    property :address_id, validates: {presence: true}
  end

  def process(params)
    validate(params[:domicile], @model) do
      contract.save
    end
  end
end
