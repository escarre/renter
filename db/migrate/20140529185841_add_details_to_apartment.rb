class AddDetailsToApartment < ActiveRecord::Migration
  def change
    add_column :apartments, :city, :string
    add_column :apartments, :state, :string
    add_column :apartments, :zip, :integer
    add_column :apartments, :landlord_email, :string
    add_column :apartments, :landlord_name, :string
    add_column :apartments, :confirm_code, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
