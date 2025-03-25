require 'application_system_test_case'

class ContactsSystemTest < ApplicationSystemTestCase
  test 'creating a contact' do
    visit contacts_url
    click_on 'New Contact'

    fill_in 'Name', with: 'Alice Doe'
    fill_in 'Email', with: 'alice@example.com'
    click_on 'Create Contact'

    assert_text 'Contact was successfully created'
    assert_text 'Alice Doe'
    assert_text 'alice@example.com'
  end

  test 'updating a contact' do
    visit contacts_url
    click_on 'Edit', match: :first

    fill_in 'Name', with: 'Updated Name'
    click_on 'Update Contact'

    assert_text 'Contact was successfully updated'
    assert_text 'Updated Name'
  end

  test 'destroying a contact' do
    visit contacts_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Contact was successfully destroyed'
  end
end
