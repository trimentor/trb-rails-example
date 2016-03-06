require 'rails_helper'

RSpec.describe Domicile::Update do
  let(:person) { Person::Create.(person: {first_name: 'MyFirstName'}).model }

  let(:address) do
    Address::Create.(address: {
      street_name: 'MyStreetName',
      street_number: 'MyStreetNumber',
      postal_code: 'MyPostalCode',
      country: 'MyCountry'
    }).model
  end

  let(:domicile) do
    Domicile::Create.(domicile: {
      person_id: person.id,
      address_id: address.id
    }).model
  end

  context 'when valid' do
    it do
      new_address = Address::Create.(address: {
        street_name: 'MyStreetName',
        street_number: 'MyStreetNumber',
        postal_code: 'MyPostalCode',
        country: 'MyOtherCountry'
      }).model

      res, op = Domicile::Update.run({
        id: domicile.id,
        domicile: {
          person_id: person.id,
          address_id: new_address.id
        }
      })

      expect(res).to eq(true)

      expect(person.domicile.address).to eq(new_address)
    end
  end
end
