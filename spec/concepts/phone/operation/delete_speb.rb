require 'rails_helper'

RSpec.describe Phone::Delete do
  let(:person) { Person::Create.(person: {first_name: 'MyFirstName'}).model }

  let(:phone) do
    Phone::Create.(phone: {
      person_id: person.id,
      telephone_number: '+1234567890',
      telephone_type: Phone.telephone_types[:cell_phone],
      category: Phone.categories[:personal_use]
    }).model
  end

  context 'when id exists' do
    it 'can be deleted' do
      res, op = Phone::Delete.run(id: phone.id)

      expect(res).to eq(true)

      expect(op.model.destroyed?).to eq(true)
    end
  end

  context 'when id doesn\'t exist' do
    it do
      expect{ Phone::Delete.run(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
