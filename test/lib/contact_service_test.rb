require 'test_helper'

class ContactServiceTest < ActiveSupport::TestCase
  def setup
    @service = ContactService.new
  end

  test 'should validate contact email format' do
    valid_email = 'john.doe@example.com'
    invalid_email = 'invalid-email'

    assert @service.valid_email?(valid_email)
    assert_not @service.valid_email?(invalid_email)
  end

  test 'should return all contacts sorted by name' do
    Contact.delete_all
    Contact.create!(name: 'Jane Smith', email: 'jane.smith@example.com')
    Contact.create!(name: 'John Doe', email: 'john.doe@example.com')

    sorted_contacts = @service.all_contacts_sorted_by_name
    assert_equal 'Jane Smith', sorted_contacts.first.name
    assert_equal 'John Doe', sorted_contacts.last.name
  end
end
