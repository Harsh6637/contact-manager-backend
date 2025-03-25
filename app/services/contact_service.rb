class ContactService
  def valid_email?(email)
    /\A[^@\s]+@[^@\s]+\z/.match?(email)
  end

  def all_contacts_sorted_by_name
    Contact.order(:name)
  end
end
