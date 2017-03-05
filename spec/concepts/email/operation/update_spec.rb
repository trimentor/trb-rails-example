require 'rails_helper'

RSpec.describe Email::Update do
  let(:person) { Person::Create.({first_name: 'MyFirstName'})["model"] }

  let(:email) do
    Email::Create.({
      person_id: person.id,
      address: 'email@example.com',
      category: Email.categories[:personal_use]
    })["model"]
  end

  context 'when valid' do
    it do
      Email::Update.({
        id: email.id,
        address: 'update.email@example.com',
        category: Email.categories[:work_related]
      })

      email.reload

      expect(email.address).to eq('update.email@example.com')

      expect(email.work_related?).to eq(true)
    end
  end

  context 'when person_id is blank' do
    it do
      res = Email::Update.({
        id: email.id,
        person_id: nil
      })

      expect(res.failure?).to eq(true)

      expect(res["contract.default"].errors.messages[:person_id]).to eq(["can't be blank"])
    end
  end

  context 'when address is blank' do
    it do
      res = Email::Update.({
        id: email.id,
        address: '',
      })

      expect(res.failure?).to eq(true)

      expect(res["contract.default"].errors.messages[:address]).to eq(["can't be blank"])
    end
  end

  context 'when category is not valid' do
    it do
      res = Email::Update.({
        id: email.id,
        category: -1
      })

      expect(res.failure?).to eq(true)

      expect(res["contract.default"].errors.messages[:category]).to eq(['is not included in the list'])
    end
  end
end
