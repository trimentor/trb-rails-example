require 'rails_helper'

RSpec.describe Email::Show do
  let(:person) { Person::Create.(person: {first_name: 'MyFirstName'}).model }

  let(:email) do
    Email::Create.(email: {
      person_id: person.id,
      address: 'email@example.com',
      category: Email.categories[:personal_use]
    }).model
  end

  context 'when id exists' do
    it 'can be shown' do
      op = Email::Show.(id: email.id)

      expect(op.model).to eq(email)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Email::Show.run(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
