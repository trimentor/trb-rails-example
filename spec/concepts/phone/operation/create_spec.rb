require 'rails_helper'

RSpec.describe Phone::Create do
  let(:person) { Person::Create.({first_name: 'MyFirstName'})["model"] }

  context 'when valid' do
    it do
      res = Phone::Create.({
        person_id: person.id,
        telephone_number: '+1234567890',
        telephone_type: Phone.telephone_types[:cell_phone],
        category: Phone.categories[:personal_use]
      })

      phone = res["model"]

      expect(res.success?).to eq(true)

      expect(phone.persisted?).to eq(true)

      expect(phone.person).to eq(person)

      expect(phone.telephone_number).to eq('+1234567890')

      expect(phone.cell_phone?).to eq(true)

      expect(phone.landline?).to eq(false)

      expect(phone.personal_use?).to eq(true)

      expect(phone.work_related?).to eq(false)
    end
  end

  context 'when a person has many phones' do
    it do
      phone1 = Phone::Create.({
        person_id: person.id,
        telephone_number: '+1234567890',
        telephone_type: Phone.telephone_types[:cell_phone],
        category: Phone.categories[:personal_use]
      })["model"]

      phone2 = Phone::Create.({
        person_id: person.id,
        telephone_number: '+0123456789',
        telephone_type: Phone.telephone_types[:landline],
        category: Phone.categories[:work_related]
      })["model"]

      expect(person.phones).to include(phone1)

      expect(person.phones).to include(phone2)
    end
  end

  context 'when person_id is blank' do
    it do
      res = Phone::Create.({
        telephone_number: '+1234567890',
        telephone_type: Phone.telephone_types[:cell_phone],
        category: Phone.categories[:personal_use]
      })

      expect(res.failure?).to eq(true)

      expect(res["model"].persisted?).to eq(false)

      expect(res["contract.default"].errors.messages[:person_id]).to eq(["can't be blank"])
    end
  end

  context 'when telephone_number is blank' do
    it do
      res = Phone::Create.({
        person_id: person.id,
        telephone_number: '',
        telephone_type: Phone.telephone_types[:cell_phone],
        category: Phone.categories[:personal_use]
      })

      expect(res.failure?).to eq(true)

      expect(res["model"].persisted?).to eq(false)

      expect(res["contract.default"].errors.messages[:telephone_number]).to eq(["can't be blank"])
    end
  end

  context 'when telephone_type is not valid' do
    it do
      res = Phone::Create.({
        person_id: person.id,
        telephone_number: '+1234567890',
        telephone_type: -1,
        category: Phone.categories[:personal_use]
      })

      expect(res.failure?).to eq(true)

      expect(res["model"].persisted?).to eq(false)

      expect(res["contract.default"].errors.messages[:telephone_type]).to eq(['is not included in the list'])
    end
  end

  context 'when category is not valid' do
    it do
      res = Phone::Create.({
        person_id: person.id,
        telephone_number: '+1234567890',
        telephone_type: Phone.telephone_types[:cell_phone],
        category: -1
      })

      expect(res.failure?).to eq(true)

      expect(res["model"].persisted?).to eq(false)

      expect(res["contract.default"].errors.messages[:category]).to eq(['is not included in the list'])
    end
  end
end
