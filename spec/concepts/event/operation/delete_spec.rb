require 'rails_helper'

RSpec.describe Event::Delete do
  it 'can be deleted' do
    event = Event::Create.(event: {name: 'MyName', start_time: DateTime.now}).model

    op = Event::Delete.(id: event.id)

    expect(op.model.destroyed?).to eq(true)
  end
end
