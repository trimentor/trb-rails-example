require 'rails_helper'

RSpec.describe Birthday::Create do
  let(:start_time) { DateTime.now }
  let(:person) { Person::Create.({first_name: 'MyFirstName'})["model"] }

  context 'when valid' do
    it do
      res = Birthday::Create.({start_time: start_time, person_id: person.id})

      birthday = res["model"]

      expect(res.success?).to eq(true)

      expect(birthday.persisted?).to eq(true)

      expect(birthday.event.start_time).to be_within(0.000001).of(start_time)

      expect(birthday.person_id).to eq(person.id)
    end
  end

  context 'when person_id is blank' do
    it do
      res = Birthday::Create.({start_time: start_time})

      expect(res.failure?).to eq(true)

      expect(res["model"].persisted?).to eq(false)

      expect(res["contract.default"].errors.messages[:person_id]).to eq(["can't be blank"])
    end
  end

  context 'when start_time is blank' do
    it do
      res = Birthday::Create.({person_id: person.id})

      expect(res.failure?).to eq(true)

      expect(res["model"].persisted?).to eq(false)

      expect(res["contract.default"].errors.messages[:start_time]).to eq(["can't be blank"])
    end
  end

  it 'can only have one birthday' do
    Birthday::Create.({start_time: start_time, person_id: person.id})

    res = Birthday::Create.({start_time: start_time, person_id: person.id})

    expect(res.failure?).to eq(true)

    expect(res["contract.default"].errors.messages[:person_id]).to eq(['can only have one birthday'])
  end
end
