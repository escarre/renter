class AddVerificationToApartment < ActiveRecord::Migration
  def change
    add_column :apartments, :code, :string
    add_column :apartments, :code_match, :boolean
    add_column :apartments, :match_date, :datetime
  end
end
