require 'rails_helper'

RSpec.describe Person::Create do
  context 'when valid' do
    it do
      res = Person::Create.({
        first_name: 'MyFirstName',
        middle_name: 'MyMiddleName',
        last_name: 'MyLastName'
      })

      expect(res.success?).to eq(true)

      person = res["model"]

      expect(person.persisted?).to eq(true)

      expect(person.first_name).to eq('MyFirstName')

      expect(person.middle_name).to eq('MyMiddleName')

      expect(person.last_name).to eq('MyLastName')
    end
  end

  context 'when first_name is blank' do
    it do
      res = Person::Create.({
        first_name: ''
      })

      expect(res.failure?).to eq(true)

      expect(res["model"].persisted?).to eq(false)

      expect(res["contract.default"].errors.messages[:first_name]).to eq(["can't be blank"])
    end
  end
end
