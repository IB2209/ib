class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :company
      t.string :name
      t.string :phone
      t.string :email
      t.text :content

      t.timestamps
    end
  end
end
