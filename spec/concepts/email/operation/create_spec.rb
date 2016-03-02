require 'rails_helper'

RSpec.describe Email::Create do
  let(:person) { Person::Create.(person: {first_name: 'MyFirstName'}).model }

  context 'when valid' do
    it do
      op = Email::Create.(email: {
        person_id: person.id,
        address: 'email@example.com',
        category: Email.categories[:personal_use]
      })

      email = op.model

      expect(email.persisted?).to eq(true)

      expect(email.person).to eq(person)

      expect(email.address).to eq('email@example.com')

      expect(email.personal_use?).to eq(true)

      expect(email.work_related?).to eq(false)
    end
  end

  context 'when a person has many emails' do
    it do
      email1 = Email::Create.(email: {
        person_id: person.id,
        address: 'email1@example.com',
        category: Email.categories[:personal_use]
      }).model

      email2 = Email::Create.(email: {
        person_id: person.id,
        address: 'email2@example.com',
        category: Email.categories[:work_related]
      }).model

      expect(person.emails).to include(email1)

      expect(person.emails).to include(email2)
    end
  end

  context 'when person_id is blank' do
    it do
      res, op = Email::Create.run(email: {
        address: 'email@example.com',
        category: Email.categories[:personal_use]
      })

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)

      expect(op.errors.messages[:person_id]).to eq(["can't be blank"])
    end
  end

  context 'when address is blank' do
    it do
      res, op = Email::Create.run(email: {
        person_id: person.id,
        address: '',
        category: Email.categories[:personal_use]
      })

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)

      expect(op.errors.messages[:address]).to eq(["can't be blank"])
    end
  end

  context 'when category is not valid' do
    it do
      res, op = Email::Create.run(email: {
        person_id: person.id,
        address: 'email@example.com',
        category: -1
      })

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)

      expect(op.errors.messages[:category]).to eq(['is not included in the list'])
    end
  end
end
