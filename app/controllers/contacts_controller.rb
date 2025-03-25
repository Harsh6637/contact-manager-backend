require 'amatch'

class ContactsController < ApplicationController
  def index
    render json: Contact.all
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact, status: :created
    else
      render json: { error: contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    head :no_content
  end

def search
  query = params[:query]
  return render json: [] if query.blank?

  matcher = Amatch::JaroWinkler.new(query.downcase)
  contacts = Contact.all.select do |contact|
    name_score = matcher.match(contact.name.downcase)
    email_score = matcher.match(contact.email.downcase)

    name_score > 0.8 || email_score > 0.8
  end

  render json: contacts
end
	

  private

  def contact_params
    params.require(:contact).permit(:name, :email)
  end
end
