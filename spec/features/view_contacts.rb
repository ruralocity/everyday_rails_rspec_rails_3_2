require 'spec_helper'

feature "View contacts" do
  background do
    @bob = create(:contact,
      firstname: 'Bob',
      lastname: 'Burns',
      email: 'bob@example.com')
    create(:contact, firstname: 'Bob', lastname: 'Conway')
  end

  scenario "lists a contact's information" do
    visit root_path
    click_link 'Bob Burns'
    within 'h1' do
      expect(page).to have_content 'Bob Burns'
    end
    expect(page).to have_content 'bob@example.com'
    @bob.phones.each do |phone|
      expect(page).to have_content phone.phone
    end
  end

  scenario "filters contacts by letter" do
    visit contacts_url
    within '#navigation' do
      click_link 'B'
    end
    expect(page).to have_content 'Bob Burns'
    expect(page).to_not have_content 'Bob Conway'
  end
end
