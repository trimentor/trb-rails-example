class Address::Create < Trailblazer::Operation
  extend Contract::DSL

  contract do
    property :street_name
    property :street_number
    property :city_area_or_district
    property :city_town_or_village
    property :postal_code
    property :country

    validates :street_name, presence: true
    validates :street_number, presence: true
    validates :postal_code, presence: true
    validates :country, presence: true

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

  step Model(Address, :new)
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()
end
