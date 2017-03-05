require 'rails_helper'

RSpec.describe Birthday::Show do
  let(:start_time) { DateTime.now }
  let(:person) { Person::Create.({first_name: 'MyFirstName'})["model"] }

  context 'when person_id is given and relation is present' do
    it 'can be shown' do
      Birthday::Create.({start_time: start_time, person_id: person.id})

      res = Birthday::Show.(person_id: person.id)

      expect(res.success?).to eq(true)

      expect(res["model"].person).to eq(person)

      expect(res["model"].event.start_time).to be_within(0.000001).of(start_time)
    end
  end

  context 'when person_id is given but relation is missing' do
    it "can't be shown" do
      res = Birthday::Show.(person_id: person.id)

      expect(res.failure?).to eq(true)

      expect(res["model"]).to be_nil
    end
  end

  context 'when person_id is blank' do
    it "can't be shown" do
      res = Birthday::Show.(person_id: nil)

      expect(res.failure?).to eq(true)

      expect(res["model"]).to be_nil
    end
  end
end
