require 'rails_helper'

RSpec.describe Address::Delete do
  context 'when id exists' do
    it 'can be deleted' do
      address = Address::Create.({
        street_name: 'MyStreetName',
        street_number: 'MyStreetNumber',
        city_area_or_district: 'MyCityAreaOrDistrict',
        city_town_or_village: 'MyCityTownOrVillage',
        postal_code: 'MyPostalCode',
        country: 'MyCountry'
      })["model"]

      res = Address::Delete.(id: address.id)

      expect(res.success?).to eq(true)

      expect(res["model"].destroyed?).to eq(true)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Address::Delete.(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
