require 'rails_helper'

RSpec.describe Domicile::Create do
  let(:person1) do
    Person::Create.({
      first_name: 'MyFirstName'
    })["model"]
  end

  let(:person2) do
    Person::Create.({
      first_name: 'MyFirstName'
    })["model"]
  end

  let(:address1) do
    Address::Create.({
      street_name: 'MyStreetName',
      street_number: '1',
      city_area_or_district: 'MyCityAreaOrDistrict',
      city_town_or_village: 'MyCityTownOrVillage',
      postal_code: 'MyPostalCode',
      country: 'MyCountry'
    })["model"]
  end

  let(:address2) do
    Address::Create.({
      street_name: 'MyStreetName',
      street_number: '2',
      city_area_or_district: 'MyCityAreaOrDistrict',
      city_town_or_village: 'MyCityTownOrVillage',
      postal_code: 'MyPostalCode',
      country: 'MyCountry'
    })["model"]
  end

  context 'when valid' do
    it do
      res = Domicile::Create.({
        person_id:  person1.id,
        address_id: address1.id
      })

      domicile = res["model"]

      expect(res.success?).to eq(true)

      expect(domicile.persisted?).to eq(true)

      expect(domicile.person).to eq(person1)

      expect(domicile.address).to eq(address1)

      expect(person1.domicile).to eq(domicile)

      expect(person2.domicile).to be_nil
    end
  end

  context 'when person_id is blank' do
    it do
      res = Domicile::Create.({
        person_id:  nil,
        address_id: address1.id
      })

      expect(res.failure?).to eq(true)

      expect(res["model"].persisted?).to eq(false)

      expect(res["contract.default"].errors.messages[:person_id]).to eq(["can't be blank"])
    end
  end

  context 'when address_id is blank' do
    it do
      res = Domicile::Create.({
        person_id:  person1.id,
        address_id: nil
      })

      expect(res.failure?).to eq(true)

      expect(res["model"].persisted?).to eq(false)

      expect(res["contract.default"].errors.messages[:address_id]).to eq(["can't be blank"])
    end
  end

  context 'when assigning a person to multiple addresses' do
    it do
      Domicile::Create.({
        person_id:  person1.id,
        address_id: address1.id
      })

      res = Domicile::Create.({
        person_id:  person1.id,
        address_id: address2.id
      })

      expect(res.failure?).to eq(true)

      expect(res["model"].persisted?).to eq(false)

      expect(res["contract.default"].errors.messages[:person_id]).to eq(['can only have one domicile'])
    end
  end

  context 'when assigning people to the same address' do
    it do
      Domicile::Create.({
        person_id:  person1.id,
        address_id: address1.id
      })

      res = Domicile::Create.({
        person_id:  person2.id,
        address_id: address1.id
      })

      expect(res.success?).to eq(true)

      expect(res["model"].persisted?).to eq(true)
    end
  end
end
