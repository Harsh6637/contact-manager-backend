require 'rails_helper'

RSpec.describe 'Contacts API', type: :request do
  describe 'POST /contacts' do
    it 'creates a new contact' do
      post '/contacts', params: { contact: { name: 'Jane Doe', email: 'jane@example.com' } }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq('Jane Doe')
    end
  end

  describe 'GET /contacts/search/:query' do
    it 'returns search results' do
      Contact.create(name: 'Jane Doe', email: 'jane@example.com')
      get '/contacts/search/Jane'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).first['name']).to eq('Jane Doe')
    end
  end

  describe 'DELETE /contacts/:id' do
    it 'deletes a contact' do
      contact = Contact.create(name: 'Jane Doe', email: 'jane@example.com')
      delete "/contacts/#{contact.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
