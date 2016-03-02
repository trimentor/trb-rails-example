require 'rails_helper'

RSpec.describe Birthday::Delete do
  context 'when id exists' do
    it 'can be deleted' do
      person = Person::Create.(person: {first_name: 'MyFirstName'}).model
      birthday = Birthday::Create.(birthday: {start_time: DateTime.now, person_id: person.id}).model

      res, op = Birthday::Delete.run(id: birthday.id)

      expect(res).to eq(true)

      expect(op.model.destroyed?).to eq(true)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Birthday::Delete.run(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
