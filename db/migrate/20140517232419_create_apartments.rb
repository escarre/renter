class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :name
      t.string :address
      t.date :lease_start
      t.date :lease_end
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
