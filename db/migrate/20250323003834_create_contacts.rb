class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
    add_index :contacts, :email, unique: true
  end
end
