require 'rails_helper'

RSpec.describe Person::Show do
  context 'when id exists' do
    it 'returns the person' do
      person = Person::Create.(person: {first_name: 'MyFirstName'}).model

      res, op = Person::Show.run(id: person.id)

      expect(res).to eq(true)

      expect(op.model).to eq(person)
    end
  end

  context 'when id doesn\'t exist' do
    it do
      expect{ Person::Show.run(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
