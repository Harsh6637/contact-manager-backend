require 'test_helper'
require 'cgi'

class ContactsControllerComponentTest < ActionDispatch::IntegrationTest
  # Set up necessary test data
  def setup
    Contact.destroy_all # Clean up
    @contact = Contact.create!(name: 'John Doe', email: 'john.doe@example.com')
  end

  # Test for the index action
  test 'should list all contacts' do
    get contacts_url
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal 1, json_response.length
    assert_equal @contact.name, json_response.first['name']
    assert_equal @contact.email, json_response.first['email']
  end

  # Test for the create action with valid data
  test 'should create a new contact with valid data' do
    assert_difference 'Contact.count', 1 do
      post contacts_url, params: { contact: { name: 'Jane Doe', email: 'jane.doe@example.com' } }
    end
    assert_response :created

    json_response = JSON.parse(response.body)
    assert_equal 'Jane Doe', json_response['name']
    assert_equal 'jane.doe@example.com', json_response['email']
  end

  # Test for the create action with invalid data (provided by you)
  test 'should not create a contact with invalid data' do
    assert_no_difference 'Contact.count' do
      post contacts_url, params: { contact: { name: '', email: '' } }
    end
    assert_response :unprocessable_entity
  end

  # Test for the destroy action
  test 'should delete a contact' do
    assert_difference 'Contact.count', -1 do
      delete contact_url(@contact)
    end
    assert_response :no_content
  end

  # Test for attempting to delete a non-existent contact
  test 'should return 404 when deleting a non-existent contact' do
    assert_no_difference 'Contact.count' do
      delete contact_url(id: -1)
    end
    assert_response :not_found
  end

  # Test for the search action
  test 'should search contacts by name or email' do
    # Create additional contacts for testing
    contact1 = Contact.create!(name: 'Jane Doe', email: 'jane.doe@example.com')
    contact2 = Contact.create!(name: 'John Smith', email: 'john.smith@example.com')

    query = CGI.escape('john')
    get "/contacts/search/#{query}"

    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal 2, json_response.length
    assert_includes json_response.map { |contact| contact['name'] }, 'John Doe'
    assert_includes json_response.map { |contact| contact['name'] }, 'John Smith'
  end
end
