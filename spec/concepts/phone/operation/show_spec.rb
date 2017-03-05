require 'rails_helper'

RSpec.describe Phone::Show do
  let(:person) { Person::Create.({first_name: 'MyFirstName'})["model"] }

  let(:phone) do
    Phone::Create.({
      person_id: person.id,
      telephone_number: '+1234567890',
      telephone_type: Phone.telephone_types[:cell_phone],
      category: Phone.categories[:personal_use]
    })["model"]
  end

  context 'when id exists' do
    it 'can be shown' do
      res = Phone::Show.(id: phone.id)

      expect(res.success?).to eq(true)

      expect(res["model"]).to eq(phone)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Phone::Show.(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
