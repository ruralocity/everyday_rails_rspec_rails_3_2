require 'spec_helper'

feature "Manage contacts" do
  background do
    user = create(:user)
    sign_in(user)
  end

  scenario "adds a new contact and displays the results" do
    visit root_path
    expect{
      click_link 'New Contact'
      fill_in 'Firstname', with: "John"
      fill_in 'Lastname', with: "Smith"
      fill_in 'Email', with: 'johnsmith@example.com'
      fill_in 'home', with: "555-1234"
      fill_in 'office', with: "555-3324"
      fill_in 'mobile', with: "555-7888"
      click_button "Create Contact"
    }.to change(Contact,:count).by(1)

    expect(page).to have_content "Contact was successfully created."
    expect(page).to have_content "John Smith"
    expect(page).to have_content "johnsmith@example.com"
    expect(page).to have_content "home 555-1234"
    expect(page).to have_content "office 555-3324"
    expect(page).to have_content "mobile 555-7888"
  end

  scenario "edits a contact and displays the updated results", js: true do
    contact = create(:contact, firstname: 'Sam', lastname: 'Smith')
    visit root_path
    click_link 'Toggle Admin'
    within "#contact_#{contact.id}" do
      click_link 'Edit'
    end
    fill_in 'Firstname', with: 'Samuel'
    fill_in 'Lastname', with: 'Smith, Jr.'
    fill_in 'Email', with: 'samsmith@example.com'
    fill_in 'home', with: '123-555-1234'
    fill_in 'work', with: '123-555-3333'
    fill_in 'mobile', with: '123-555-7777'
    click_button 'Update Contact'

    expect(page).to have_content 'Contact was successfully updated'
    expect(page).to have_content 'Samuel Smith, Jr.'
    expect(page).to have_content 'samsmith@example.com'
    expect(page).to have_content '123-555-1234'
    expect(page).to have_content '123-555-3333'
    expect(page).to have_content '123-555-7777'
  end

  scenario "deletes a contact" do
    contact = create(:contact, firstname: "Aaron", lastname: "Sumner")
    visit root_path
    expect{
      within "#contact_#{contact.id}" do
        click_link 'Destroy'
      end
    }.to change(Contact,:count).by(-1)
    expect(page).to have_content "Contacts"
    expect(page).to_not have_content "Aaron Sumner"
  end
end
