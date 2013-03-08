class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.references :contact
      t.string :phone
      t.string :phone_type

      t.timestamps
    end
    add_index :phones, :contact_id
  end
end
