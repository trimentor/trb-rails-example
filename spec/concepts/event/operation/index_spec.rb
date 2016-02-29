require 'rails_helper'

RSpec.describe Event::Index do
  it 'returns all events' do
    event1 = Event::Create.(event: {name: 'MyName', start_time: DateTime.now}).model
    event2 = Event::Create.(event: {name: 'MyName', start_time: DateTime.now + 1.day}).model

    events = Event::Index.({}).model

    expect(events.count).to eq(2)

    expect(events).to include(event1)

    expect(events).to include(event2)
  end
end
