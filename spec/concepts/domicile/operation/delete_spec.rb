require 'rails_helper'

RSpec.describe Domicile::Delete do
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

  context 'when id exists' do
    it 'can be deleted' do
      res = Domicile::Delete.(id: domicile.id)

      expect(res.success?).to eq(true)

      expect(res["model"].destroyed?).to eq(true)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Domicile::Delete.(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
