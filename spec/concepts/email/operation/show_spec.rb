require 'rails_helper'

RSpec.describe Email::Show do
  let(:person) { Person::Create.({first_name: 'MyFirstName'})["model"] }

  let(:email) do
    Email::Create.({
      person_id: person.id,
      address: 'email@example.com',
      category: Email.categories[:personal_use]
    })["model"]
  end

  context 'when id exists' do
    it 'can be shown' do
      res = Email::Show.(id: email.id)

      expect(res.success?).to eq(true)

      expect(res["model"]).to eq(email)
    end
  end

  context "when id doesn't exist" do
    it do
      expect{ Email::Show.(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
