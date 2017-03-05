require 'rails_helper'

RSpec.describe Person::Update do
  let(:person) { Person::Create.({
    first_name: 'MyFirstName',
    middle_name: 'MyMiddleName',
    last_name: 'MyLastName'})["model"]
  }

  context 'when valid' do
    it do
      Person::Update.(
        id: person.id,
        first_name: 'UpdateFirstName'
      )

      person.reload

      expect(person.first_name).to eq('UpdateFirstName')
    end
  end

  context 'when first_name is blank' do
    it do
      res = Person::Update.(
        id: person.id,
        first_name: ''
      )

      expect(res.failure?).to eq(true)

      expect(res["contract.default"].errors.messages[:first_name]).to eq(["can't be blank"])
    end
  end
end
