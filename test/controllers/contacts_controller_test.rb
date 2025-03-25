require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Contact.delete_all
    @contact = Contact.create!(name: 'John Doe', email: 'john.doe@example.com')
    assert @contact.persisted?, "Setup contact was not saved!"
  end

  test 'should get index' do
    get contacts_url, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert json_response.is_a?(Array), "Expected response to be an array"
  end

  test 'should create a contact' do
    assert_difference('Contact.count', 1) do
      post contacts_url, params: { contact: { name: 'Alice Doe', email: 'alice@example.com' } }, as: :json
    end
    assert_response :created
    json_response = JSON.parse(response.body)
    assert_equal 'Alice Doe', json_response['name']
    assert_equal 'alice@example.com', json_response['email']
  end

  test 'should not create a contact with invalid data' do
    assert_no_difference('Contact.count') do
      post contacts_url, params: { contact: { name: '', email: '' } }, as: :json
    end
    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert json_response['error'].present?, "Expected error messages in response but got #{json_response}"
  end

  test 'should destroy contact' do
    assert_difference('Contact.count', -1) do
      delete contact_url(@contact), as: :json
    end
    assert_response :no_content
  end

  test 'should return 404 for destroying non-existing contact' do
    assert_no_difference('Contact.count') do
      delete contact_url(-1), as: :json
    end
    assert_response :not_found
  end

  test 'should search contacts' do
    get "/contacts/search/John", as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert json_response.is_a?(Array), "Expected response to be an array"
    assert_not_empty json_response, "Search did not return expected results"
  end
end
