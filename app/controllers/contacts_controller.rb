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
    contacts = Contact.where('name LIKE ? OR email LIKE ?', "%#{query}%", "%#{query}%")
    render json: contacts
  end
	

  private

  def contact_params
    params.require(:contact).permit(:name, :email)
  end
end
