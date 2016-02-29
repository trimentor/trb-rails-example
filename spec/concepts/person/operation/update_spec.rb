require 'rails_helper'

RSpec.describe Person::Update do
  let(:person) { Person::Create.(person: {
    first_name: 'MyFirstName',
    middle_name: 'MyMiddleName',
    last_name: 'MyLastName'}).model
  }

  context 'when valid' do
    it do
      Person::Update.(
        id: person.id,
        person: {
          first_name: 'UpdateFirstName'
        }
      )

      person.reload

      expect(person.first_name).to eq('UpdateFirstName')
    end
  end

  context 'when first_name is blank' do
    it do
      res, op = Person::Update.run(
        id: person.id,
        person: {
          first_name: ''
        }
      )

      expect(res).to eq(false)

      expect(op.errors.messages[:first_name]).to eq(["can't be blank"])
    end
  end
end
