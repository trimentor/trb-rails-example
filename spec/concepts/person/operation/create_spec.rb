require 'rails_helper'

RSpec.describe Person::Create do
  context 'when valid' do
    it do
      op = Person::Create.(person: {
        first_name: 'MyFirstName',
        middle_name: 'MyMiddleName',
        last_name: 'MyLastName'
      })

      person = op.model

      expect(person.persisted?).to eq(true)

      expect(person.first_name).to eq('MyFirstName')

      expect(person.middle_name).to eq('MyMiddleName')

      expect(person.last_name).to eq('MyLastName')
    end
  end

  context 'when first_name is blank' do
    it do
      res, op = Person::Create.run(person: {
        first_name: ''
      })

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)

      expect(op.errors.messages[:first_name]).to eq(["can't be blank"])
    end
  end
end
