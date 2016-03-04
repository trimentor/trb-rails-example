require 'rails_helper'

RSpec.describe Event::Create do
  let(:start_time) { DateTime.now }
  let(:end_time)   { start_time + 1.day }

  context 'when valid' do
    it do
      op = Event::Create.(event: {
        name: 'MyName',
        location: 'MyLocation',
        start_time: start_time,
        end_time: end_time,
        description: 'MyDescription'
      })

      event = op.model

      expect(event.persisted?).to eq(true)

      expect(event.name).to eq('MyName')

      expect(event.location).to eq('MyLocation')

      expect(event.start_time).to eq(start_time)

      expect(event.end_time).to eq(end_time)

      expect(event.description).to eq('MyDescription')
    end

    it do
      res, op = Event::Create.run(event: {
        name: 'MyName',
        start_time: start_time
      })

      expect(res).to eq(true)
    end
  end

  context 'when invalid' do
    it do
      res, op = Event::Create.run(event: {})

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)
    end
  end

  context 'without name' do
    it do
      res, op = Event::Create.run(event: {
        location: 'MyLocation',
        start_time: start_time,
        end_time: end_time,
        description: 'MyDescription'
      })

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)

      expect(op.errors.messages[:name]).to eq(["can't be blank"])
    end
  end

  context 'without start_time' do
    it do
      res, op = Event::Create.run(event: {
        name: 'MyName',
        location: 'MyLocation',
        end_time: end_time,
        description: 'MyDescription'
      })

      expect(res).to eq(false)

      expect(op.model.persisted?).to eq(false)

      expect(op.errors.messages[:start_time]).to eq(["can't be blank"])
    end
  end
end
