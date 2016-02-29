require 'rails_helper'

RSpec.describe Person::Delete do
  context 'when id exists' do
    it 'can be deleted' do
      person = Person::Create.(person: {first_name: 'MyFirstName'}).model

      res, op = Person::Delete.run(id: person.id)

      expect(res).to eq(true)

      expect(op.model.destroyed?).to eq(true)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Person::Delete.run(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
