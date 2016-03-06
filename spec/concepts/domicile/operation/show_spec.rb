require 'rails_helper'

RSpec.describe Domicile::Show do
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

  context 'when id exists' do
    it 'can be shown' do
      op = Domicile::Show.(id: domicile.id)

      expect(op.model.person).to eq(person)

      expect(op.model.address).to eq(address)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Domicile::Show.run(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
