require 'rails_helper'

RSpec.describe Person::Show do
  context 'when id exists' do
    it 'returns the person' do
      person = Person::Create.({first_name: 'MyFirstName'})["model"]

      res = Person::Show.(id: person.id)

      expect(res.success?).to eq(true)

      expect(res["model"]).to eq(person)
    end
  end

  context 'when id doesn\'t exist' do
    it do
      expect{ Person::Show.(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
