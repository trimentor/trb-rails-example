require 'rails_helper'

RSpec.describe Birthday::Create do
  let(:start_time) { DateTime.now }
  let(:person) { Person::Create.(person: {first_name: 'MyFirstName'}).model }

  context 'when valid' do
    it do
      birthday = Birthday::Create.(birthday: {start_time: start_time, person_id: person.id}).model

      expect(birthday.persisted?).to eq(true)

      expect(birthday.event.start_time).to be_within(0.000001).of(start_time)

      expect(birthday.person_id).to eq(person.id)
    end
  end

  context 'when person_id is blank' do
    it do
      res, op = Birthday::Create.run(birthday: {start_time: start_time})

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)

      expect(op.errors.messages[:person_id]).to eq(["can't be blank"])
    end
  end

  context 'when start_time is blank' do
    it do
      res, op = Birthday::Create.run(birthday: {person_id: person.id})

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)

      expect(op.errors.messages[:start_time]).to eq(["can't be blank"])
    end
  end
end
