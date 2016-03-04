class Address::Update < Trailblazer::Operation
  include Model
  model Address, :update

  contract do
    property :street_name, validates: {presence: true}
    property :street_number, validates: {presence: true}
    property :city_area_or_district
    property :city_town_or_village
    property :postal_code, validates: {presence: true}
    property :country, validates: {presence: true}

    validate :street_postal_code_country_uniqueness

    def street_postal_code_country_uniqueness
      address_unique = Address.where(
        street_name: street_name,
        street_number: street_number,
        postal_code: postal_code,
        country: country
      ).empty?

      errors.add(:street_number, 'must be unique') unless address_unique
    end
  end

  def process(params)
    validate(params[:address], @model) do
      contract.save
    end
  end
end
