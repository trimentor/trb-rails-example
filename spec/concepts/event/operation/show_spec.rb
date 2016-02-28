require 'rails_helper'

RSpec.describe Event::Show do
  it do
    event = Event::Create.(event: {name: 'MyName', start_time: DateTime.now}).model

    res, op = Event::Show.run(id: event.id)

    expect(res).to eq(true)

    expect(op.model.id).to eq(event.id)
  end
end
