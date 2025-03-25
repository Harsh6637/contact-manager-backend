require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  def setup
    Contact.delete_all
    @contact = Contact.new(name: 'John Doe', email: 'john.doe@example.com')
  end

  test 'should be valid with valid attributes' do
    assert @contact.valid?
  end

  test 'should be invalid without a name' do
    @contact.name = ''
    assert_not @contact.valid?
    assert_includes @contact.errors[:name], "can't be blank"
  end

  test 'should be invalid without an email' do
    @contact.email = ''
    assert_not @contact.valid?
    assert_includes @contact.errors[:email], "can't be blank"
  end

	test 'should be invalid with an improperly formatted email' do
		contact = Contact.new(name: 'John Doe', email: 'invalid-email')
		assert_not contact.valid?
		assert_includes contact.errors[:email], 'is invalid'
	end


  test 'should save successfully with valid attributes' do
    assert_difference('Contact.count', 1) do
      @contact.save
    end
  end
end
