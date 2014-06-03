class AddSlugToApartments < ActiveRecord::Migration
  def change
    add_column :apartments, :slug, :string
    add_index :apartments, :slug, unique: true
  end
end
