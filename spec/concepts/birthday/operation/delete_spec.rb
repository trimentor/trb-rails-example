require 'rails_helper'

RSpec.describe Birthday::Delete do
  context 'when id exists' do
    it 'can be deleted' do
      person = Person::Create.({first_name: 'MyFirstName'})["model"]
      birthday = Birthday::Create.({start_time: DateTime.now, person_id: person.id})["model"]

      res = Birthday::Delete.(id: birthday.id)

      expect(res.success?).to eq(true)

      expect(res["model"].destroyed?).to eq(true)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Birthday::Delete.(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
