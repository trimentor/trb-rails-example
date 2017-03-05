require 'rails_helper'

RSpec.describe Person::Delete do
  context 'when id exists' do
    it 'can be deleted' do
      person = Person::Create.({first_name: 'MyFirstName'})["model"]

      res = Person::Delete.(id: person.id)

      expect(res.success?).to eq(true)

      expect(res["model"].destroyed?).to eq(true)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Person::Delete.(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
