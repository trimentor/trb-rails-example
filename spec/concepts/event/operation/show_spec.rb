require 'rails_helper'

RSpec.describe Event::Show do
  context 'when id exists' do
    it 'can be shown' do
      event = Event::Create.(event: {name: 'MyName', start_time: DateTime.now}).model

      res, op = Event::Show.run(id: event.id)

      expect(res).to eq(true)

      expect(op.model.id).to eq(event.id)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Event::Show.run(id: -1).to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end
