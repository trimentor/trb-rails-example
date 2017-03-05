require 'rails_helper'

RSpec.describe Address::Update do
  let(:address) do
    Address::Create.({
      street_name: 'MyStreetName',
      street_number: 'MyStreetNumber',
      postal_code: 'MyPostalCode',
      country: 'MyCountry'
    })["model"]
  end

  context 'when valid' do
    it do
      res = Address::Update.({
        id: address.id,
        street_name: 'UpdateStreetName',
        street_number: 'UpdateStreetNumber',
        city_area_or_district: 'UpdateCityAreaOrDistrict',
        city_town_or_village: 'UpdateCityTownOrVillage',
        postal_code: 'UpdatePostalCode',
        country: 'UpdateCountry'
      })

      address.reload

      expect(res.success?).to eq(true)

      expect(address.street_name).to eq('UpdateStreetName')

      expect(address.street_number).to eq('UpdateStreetNumber')

      expect(address.city_area_or_district).to eq('UpdateCityAreaOrDistrict')

      expect(address.city_town_or_village).to eq('UpdateCityTownOrVillage')

      expect(address.postal_code).to eq('UpdatePostalCode')

      expect(address.country).to eq('UpdateCountry')
    end
  end

  context 'when street_name is blank' do
    it do
      res = Address::Update.({
        id: address.id,
        street_name: ''
      })

      expect(res.failure?).to eq(true)

      expect(res["contract.default"].errors.messages[:street_name]).to eq(["can't be blank"])
    end
  end

  context 'when street_number is blank' do
    it do
      res = Address::Update.({
        id: address.id,
        street_number: ''
      })

      expect(res.failure?).to eq(true)

      expect(res["contract.default"].errors.messages[:street_number]).to eq(["can't be blank"])
    end
  end

  context 'when postal_code is blank' do
    it do
      res = Address::Update.({
        id: address.id,
        postal_code: ''
      })

      expect(res.failure?).to eq(true)

      expect(res["contract.default"].errors.messages[:postal_code]).to eq(["can't be blank"])
    end
  end

  context 'when country is blank' do
    it do
      res = Address::Update.({
        id: address.id,
        country: ''
      })

      expect(res.failure?).to eq(true)

      expect(res["contract.default"].errors.messages[:country]).to eq(["can't be blank"])
    end
  end

  context 'when address is not unique' do
    it do
      existing_address = Address::Create.({
        street_name: 'MyStreetName',
        street_number: '1',
        postal_code: 'MyPostalCode',
        country: 'MyCountry'
      })["model"]

      res = Address::Update.({
        id: address.id,
        street_name: existing_address.street_name,
        street_number: existing_address.street_number,
        postal_code: existing_address.postal_code,
        country: existing_address.country
      })

      expect(res.failure?).to eq(true)

      expect(res["contract.default"].errors.messages[:street_number]).to eq(['must be unique'])
    end
  end
end
