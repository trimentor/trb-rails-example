require 'rails_helper'

RSpec.describe Event::Delete do
  context 'when id exists' do
    it 'can be deleted' do
      event = Event::Create.({name: 'MyName', start_time: DateTime.now})["model"]

      res = Event::Delete.(id: event.id)

      expect(res.success?).to eq(true)

      expect(res["model"].destroyed?).to eq(true)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Event::Delete.(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
