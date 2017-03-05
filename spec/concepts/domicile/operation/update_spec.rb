require 'rails_helper'

RSpec.describe Domicile::Update do
  let(:person) { Person::Create.({first_name: 'MyFirstName'})["model"] }

  let(:address) do
    Address::Create.({
      street_name: 'MyStreetName',
      street_number: 'MyStreetNumber',
      postal_code: 'MyPostalCode',
      country: 'MyCountry'
    })["model"]
  end

  let(:domicile) do
    Domicile::Create.({
      person_id: person.id,
      address_id: address.id
    })["model"]
  end

  context 'when valid' do
    it do
      new_address = Address::Create.({
        street_name: 'MyStreetName',
        street_number: 'MyStreetNumber',
        postal_code: 'MyPostalCode',
        country: 'MyOtherCountry'
      })["model"]

      res = Domicile::Update.({
        id: domicile.id,
        person_id: person.id,
        address_id: new_address.id
      })

      expect(res.success?).to eq(true)

      expect(person.domicile.address).to eq(new_address)
    end
  end
end
