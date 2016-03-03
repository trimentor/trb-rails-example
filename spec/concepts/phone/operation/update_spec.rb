require 'rails_helper'

RSpec.describe Phone::Update do
  let(:person) { Person::Create.(person: {first_name: 'MyFirstName'}).model }

  let(:phone) do
    Phone::Create.(phone: {
      person_id: person.id,
      telephone_number: '+1234567890',
      telephone_type: Phone.telephone_types[:cell_phone],
      category: Phone.categories[:personal_use]
    }).model
  end

  context 'when valid' do
    it do
      Phone::Update.({
        id: phone.id,
        phone: {
          telephone_number: '+0123456789',
          telephone_type: Phone.telephone_types[:landline],
          category: Phone.categories[:work_related]
        }
      })

      phone.reload

      expect(phone.telephone_number).to eq('+0123456789')

      expect(phone.cell_phone?).to eq(false)

      expect(phone.landline?).to eq(true)

      expect(phone.personal_use?).to eq(false)

      expect(phone.work_related?).to eq(true)
    end
  end

  context 'when person_id is blank' do
    it do
      res, op = Phone::Update.run({
        id: phone.id,
        phone: {
          person_id: nil
        }
      })

      expect(res).to eq(false)

      expect(op.errors.messages[:person_id]).to eq(["can't be blank"])
    end
  end

  context 'when telephone_number is blank' do
    it do
      res, op = Phone::Update.run({
        id: phone.id,
        phone: {
          telephone_number: '',
        }
      })

      expect(res).to eq(false)

      expect(op.errors.messages[:telephone_number]).to eq(["can't be blank"])
    end
  end

  context 'when telephone_type is not valid' do
    it do
      res, op = Phone::Update.run({
        id: phone.id,
        phone: {
          telephone_type: -1,
        }
      })

      expect(res).to eq(false)

      expect(op.errors.messages[:telephone_type]).to eq(['is not included in the list'])
    end
  end

  context 'when category is not valid' do
    it do
      res, op = Phone::Update.run({
        id: phone.id,
        phone: {
          category: -1
        }
      })

      expect(res).to eq(false)

      expect(op.errors.messages[:category]).to eq(['is not included in the list'])
    end
  end
end
