require 'rails_helper'

RSpec.describe Event::Update do
  let(:start_time) { DateTime.now }
  let(:event) { Event::Create.(event: {name: 'MyName', start_time: start_time}).model }

  context 'when valid' do
    it do
      Event::Update.(
        id: event.id,
        event: {
          name: 'UpdateName'
        }
      )

      event.reload

      expect(event.name).to eq('UpdateName')

      # expect(event.start_time).to eq(start_time) # fail
      #
      # What’s special about reloading the model? It looks like the Ruby Time
      # object maintains greater precision than the database does.
      # When the value is read back from the database, it’s only preserved to
      # microsecond precision, while the in-memory representation is precise to
      # nanoseconds.
      #
      # More info:
      # - http://blog.solanolabs.com/rails-time-comparisons-devil-details-etc/
      # - http://www.postgresql.org/docs/9.4/static/datatype-datetime.html
      #
      # Workaround:
      expect(event.start_time).to be_within(0.000001).of(start_time)
    end
  end

  context 'when name is blank' do
    it do
      res, op = Event::Update.run(
        id: event.id,
        event: {
          name: ''
        }
      )

      expect(res).to eq(false)

      expect(op.errors.messages[:name]).to eq(['can\'t be blank'])
    end
  end

  context 'when start_time is blank' do
    it do
      res, op = Event::Update.run(
        id: event.id,
        event: {
          start_time: ''
        }
      )

      expect(res).to eq(false)

      expect(op.errors.messages[:start_time]).to eq(['can\'t be blank'])
    end
  end
end
