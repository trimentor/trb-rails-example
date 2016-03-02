require 'rails_helper'

RSpec.describe Birthday::Show do
  let(:start_time) { DateTime.now }
  let(:person) { Person::Create.(person: {first_name: 'MyFirstName'}).model }

  context 'when person_id is given and relation is present' do
    it 'can be shown' do
      Birthday::Create.(birthday: {start_time: start_time, person_id: person.id})

      res, op = Birthday::Show.run(person_id: person.id)

      expect(res).to eq(true)

      expect(op.person).to eq(person)

      expect(op.start_time).to be_within(0.000001).of(start_time)
    end
  end

  context 'when person_id is given but relation is missing' do
    it "can't be shown" do
      res, op = Birthday::Show.run(person_id: person.id)

      expect(res).to eq(false)

      expect(op.model).to be_nil
    end
  end

  context 'when person_id is blank' do
    it "can't be shown" do
      res, op = Birthday::Show.run(person_id: nil)

      expect(res).to eq(false)

      expect(op.model).to be_nil
    end
  end
end
