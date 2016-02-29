require 'rails_helper'

RSpec.describe Person::Index do
  it 'return a list of people' do
    person1 = Person::Create.(person: {first_name: 'MyFirstName'}).model
    person2 = Person::Create.(person: {first_name: 'MyFirstName'}).model

    people = Person::Index.({}).model

    expect(people.count).to eq(2)

    expect(people).to include(person1)

    expect(people).to include(person2)
  end
end
