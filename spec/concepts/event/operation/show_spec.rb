require 'rails_helper'

RSpec.describe Event::Show do
  context 'when id exists' do
    it 'can be shown' do
      event = Event::Create.({name: 'MyName', start_time: DateTime.now})["model"]

      res = Event::Show.(id: event.id)

      expect(res.success?).to eq(true)

      expect(res["model"]).to eq(event)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Event::Show.(id: -1).to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end
