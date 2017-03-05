require 'rails_helper'

RSpec.describe Event::Create do
  let(:start_time) { DateTime.now }
  let(:end_time)   { start_time + 1.day }

  context 'when valid' do
    it do
      res = Event::Create.({
        name: 'MyName',
        location: 'MyLocation',
        start_time: start_time,
        end_time: end_time,
        description: 'MyDescription'
      })

      event = res["model"]

      expect(event.persisted?).to eq(true)

      expect(event.name).to eq('MyName')

      expect(event.location).to eq('MyLocation')

      expect(event.start_time).to eq(start_time)

      expect(event.end_time).to eq(end_time)

      expect(event.description).to eq('MyDescription')
    end

    it do
      res = Event::Create.({
        name: 'MyName',
        start_time: start_time
      })

      expect(res.success?).to eq(true)
    end
  end

  context 'when invalid' do
    it do
      res = Event::Create.({})

      expect(res.failure?).to eq(true)

      expect(res["model"].persisted?).to eq(false)
    end
  end

  context 'when name is blank' do
    it do
      res = Event::Create.({
        name: '',
      })

      expect(res.failure?).to eq(true)

      expect(res["model"].persisted?).to eq(false)

      expect(res["contract.default"].errors.messages[:name]).to eq(["can't be blank"])
    end
  end

  context 'when start_time is blank' do
    it do
      res = Event::Create.({
        start_time: nil
      })

      expect(res.failure?).to eq(true)

      expect(res["model"].persisted?).to eq(false)

      expect(res["contract.default"].errors.messages[:start_time]).to eq(["can't be blank"])
    end
  end
end
