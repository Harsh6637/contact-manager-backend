require 'rails_helper'

RSpec.describe Contact, type: :model do
  it 'is valid with valid attributes' do
    contact = Contact.new(name: 'John Doe', email: 'john@example.com')
    expect(contact).to be_valid
  end

  it 'is not valid without a name' do
    contact = Contact.new(email: 'john@example.com')
    expect(contact).not_to be_valid
  end

  it 'is not valid without an email' do
    contact = Contact.new(name: 'John Doe')
    expect(contact).not_to be_valid
  end

  it 'is not valid with an invalid email' do
    contact = Contact.new(name: 'John Doe', email: 'invalid-email')
    expect(contact).not_to be_valid
  end
end
