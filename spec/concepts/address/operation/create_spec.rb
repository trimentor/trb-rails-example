require 'rails_helper'

RSpec.describe Address::Create do
  context 'when valid' do
    it do
      res, op = Address::Create.run(address: {
        street_name: 'MyStreetName',
        street_number: 'MyStreetNumber',
        city_area_or_district: 'MyCityAreaOrDistrict',
        city_town_or_village: 'MyCityTownOrVillage',
        postal_code: 'MyPostalCode',
        country: 'MyCountry'
      })

      address = op.model

      expect(res).to eq(true)

      expect(address.persisted?).to eq(true)

      expect(address.street_name).to eq('MyStreetName')

      expect(address.street_number).to eq('MyStreetNumber')

      expect(address.city_area_or_district).to eq('MyCityAreaOrDistrict')

      expect(address.city_town_or_village).to eq('MyCityTownOrVillage')

      expect(address.postal_code).to eq('MyPostalCode')

      expect(address.country).to eq('MyCountry')
    end
  end

  context 'when invalid' do
    it do
      res, op = Address::Create.run(address: {})

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)
    end
  end

  context 'when street_name is blank' do
    it do
      res, op = Address::Create.run(address: {
        street_name: '',
        street_number: 'MyStreetNumber',
        postal_code: 'MyPostalCode',
        country: 'MyCountry'
      })

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)

      expect(op.errors.messages[:street_name]).to eq(["can't be blank"])
    end
  end

  context 'when street_number is blank' do
    it do
      res, op = Address::Create.run(address: {
        street_name: 'MyStreetName',
        street_number: '',
        postal_code: 'MyPostalCode',
        country: 'MyCountry'
      })

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)

      expect(op.errors.messages[:street_number]).to eq(["can't be blank"])
    end
  end

  context 'when postal_code is blank' do
    it do
      res, op = Address::Create.run(address: {
        street_name: 'MyStreetName',
        street_number: 'MyStreetNumber',
        postal_code: '',
        country: 'MyCountry'
      })

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)

      expect(op.errors.messages[:postal_code]).to eq(["can't be blank"])
    end
  end

  context 'when country is blank' do
    it do
      res, op = Address::Create.run(address: {
        street_name: 'MyStreetName',
        street_number: 'MyStreetNumber',
        postal_code: 'MyPostalCode',
        country: ''
      })

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)

      expect(op.errors.messages[:country]).to eq(["can't be blank"])
    end
  end

  context 'when creating an address nearby' do
    it do
      Address::Create.run(address: {
        street_name: 'MyStreetName',
        street_number: '1',
        postal_code: 'MyPostalCode',
        country: 'MyCountry'
      })

      res, op = Address::Create.run(address: {
        street_name: 'MyStreetName',
        street_number: '2',
        postal_code: 'MyPostalCode',
        country: 'MyCountry'
      })

      expect(res).to eq(true)

      expect(op.model.persisted?).to eq(true)
    end
  end

  context 'when the address nearby already exists' do
    it do
      Address::Create.run(address: {
        street_name: 'MyStreetName',
        street_number: '1',
        postal_code: 'MyPostalCode',
        country: 'MyCountry'
      })

      res, op = Address::Create.run(address: {
        street_name: 'MyStreetName',
        street_number: '1',
        postal_code: 'MyPostalCode',
        country: 'MyCountry'
      })

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)

      expect(op.errors.messages[:street_number]).to eq(['must be unique'])
    end
  end

  context 'when the street name/number exists in the same country but the postal code is different' do
    it do
      Address::Create.run(address: {
        street_name: 'MyStreetName',
        street_number: '1',
        postal_code: '1',
        country: 'MyCountry'
      })

      res, op = Address::Create.run(address: {
        street_name: 'MyStreetName',
        street_number: '1',
        postal_code: '2',
        country: 'MyCountry'
      })

      expect(res).to eq(true)

      expect(op.model.persisted?).to eq(true)
    end
  end
end
