require 'rails_helper'

RSpec.describe 'people management', type: :feature do
  scenario 'User creates a new person' do
    visit '/people'

    click_link 'New person'

    fill_in 'First name',  with: 'MyFirstName'
    fill_in 'Middle name', with: 'MyMiddleName'
    fill_in 'Last name',   with: 'MyLastName'

    click_button 'Create person'

    expect(page).to have_text('MyFirstName')
    expect(page).to have_text('MyMiddleName')
    expect(page).to have_text('MyLastName')
  end

  scenario 'User updates a person' do
    op = Person::Create.(person: {
      first_name: 'name'
    })

    visit "/people/#{op.model.id}"

    click_link 'Edit person'

    fill_in 'First name',  with: 'MyFirstName'
    fill_in 'Middle name', with: 'MyMiddleName'
    fill_in 'Last name',   with: 'MyLastName'

    click_button 'Update person'

    expect(page).to have_text('Person has been updated successfully!')

    expect(page).to have_text('MyFirstName')
    expect(page).to have_text('MyMiddleName')
    expect(page).to have_text('MyLastName')
  end

  scenario 'User deletes a person' do
    op = Person::Create.(person: {
      first_name: 'name'
    })

    visit "/people/#{op.model.id}"

    click_link 'Delete person'

    expect(page).to have_text('Person has been deleted successfully!')
  end
end
