class Contact < ApplicationRecord
  validates :name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: 'is invalid' }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.search(query)
    where('name LIKE ? OR email LIKE ?', "%#{query}%", "%#{query}%")
  end
end
