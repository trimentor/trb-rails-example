require 'rails_helper'

RSpec.describe 'people management', type: :feature do
  xscenario 'User creates a new person' do
    visit '/people'

    click_link 'New Person'

    fill_in 'First name',  with: 'MyFirstName'
    fill_in 'Middle name', with: 'MyMiddleName'
    fill_in 'Last name',   with: 'MyLastName'

    click_button 'Create Person'

    expect(page).to have_text('MyFirstName')
    expect(page).to have_text('MyMiddleName')
    expect(page).to have_text('MyLastName')
  end

  xscenario 'User updates a person' do
    res = Person::Create.({
      first_name: 'name'
    })

    visit "/people/#{res["model"].id}"

    click_link 'Edit Person'

    fill_in 'First name',  with: 'MyFirstName'
    fill_in 'Middle name', with: 'MyMiddleName'
    fill_in 'Last name',   with: 'MyLastName'

    click_button 'Update Person'

    expect(page).to have_text('Person has been updated successfully!')

    expect(page).to have_text('MyFirstName')
    expect(page).to have_text('MyMiddleName')
    expect(page).to have_text('MyLastName')
  end

  xscenario 'User deletes a person' do
    res = Person::Create.({
      first_name: 'name'
    })

    visit "/people/#{res["model"].id}"

    click_link 'Delete Person'

    expect(page).to have_text('Person has been deleted successfully!')
  end
end
