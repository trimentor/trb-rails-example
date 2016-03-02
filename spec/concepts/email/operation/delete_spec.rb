require 'rails_helper'

RSpec.describe Email::Delete do
  let(:person) { Person::Create.(person: {first_name: 'MyFirstName'}).model }

  let(:email) do
    Email::Create.(email: {
      person_id: person.id,
      address: 'email@example.com',
      category: Email.categories[:personal_use]
    }).model
  end

  context 'when id exists' do
    it 'can be deleted' do
      res, op = Email::Delete.run(id: email.id)

      expect(res).to eq(true)

      expect(op.model.destroyed?).to eq(true)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Email::Delete.run(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
