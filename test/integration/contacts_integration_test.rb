require 'test_helper'

class ContactsIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    Contact.delete_all
    @contact1 = Contact.create!(name: 'John Doe', email: 'john.doe@example.com')
    @contact2 = Contact.create!(name: 'Jane Smith', email: 'jane.smith@example.com')
  end

  test 'should fetch all contacts' do
    get '/contacts'
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 2, json_response.size
    assert_equal @contact1.name, json_response[0]['name']
    assert_equal @contact2.name, json_response[1]['name']
  end

  test 'should create a new contact' do
    valid_contact = { name: 'Alice Doe', email: 'alice.doe@example.com' }
    assert_difference('Contact.count', 1) do
      post '/contacts', params: { contact: valid_contact }
    end
    assert_response :created
    json_response = JSON.parse(response.body)
    assert_equal valid_contact[:name], json_response['name']
    assert_equal valid_contact[:email], json_response['email']
  end

	test 'should not create a contact with invalid data' do
		invalid_contact = { name: '', email: '' }
		  post '/contacts', params: { contact: invalid_contact }
  		assert_response :unprocessable_entity
  		json_response = JSON.parse(response.body)
   		assert_not_nil json_response['error'], "Expected 'error' key to be present in the JSON response, but got: #{json_response.inspect}"
  		assert_includes json_response['error'], "Name can't be blank" # Ensure specific validation message is included
  		assert_includes json_response['error'], "Email can't be blank" # Check for another validation message
	end


  test 'should delete a contact' do
    assert_difference('Contact.count', -1) do
      delete "/contacts/#{@contact1.id}"
    end
    assert_response :no_content
  end
end
