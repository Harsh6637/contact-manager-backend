require 'application_system_test_case'

class ContactsSystemTest < ApplicationSystemTestCase
  test 'creating a contact' do
    visit contacts_path
    fill_in 'Name', with: 'John'
    fill_in 'Email', with: 'john@example.com'
    click_button 'Add Contact'

    assert_text 'Contact added successfully'
    assert_text 'John'
    assert_text 'john@example.com'
  end

  test 'searching for a contact' do
    visit contacts_path
    fill_in 'Search', with: 'John'
    click_button 'Search'

    assert_text 'John'
  end

  test 'deleting a contact' do
    visit contacts_path
    click_button 'Delete'

    assert_text 'Contact deleted successfully'
  end
end
