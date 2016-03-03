require 'rails_helper'

RSpec.describe Event::Delete do
  context 'when id exists' do
    it 'can be deleted' do
      event = Event::Create.(event: {name: 'MyName', start_time: DateTime.now}).model

      res, op = Event::Delete.run(id: event.id)

      expect(res).to eq(true)

      expect(op.model.destroyed?).to eq(true)
    end
  end

  context 'when id doesn\'t exist' do
    it do
      expect{ Event::Delete.run(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
