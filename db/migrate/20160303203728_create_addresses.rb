class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :street_name, null: false
      t.string :street_number, null: false
      t.string :city_area_or_district, index: true
      t.string :city_town_or_village, index: true
      t.string :postal_code, null: false, index: true
      t.string :country, null: false, index: true
    end

    add_index :addresses, [
      :street_name,
      :street_number,
      :postal_code,
      :country
    ],
    unique: true,
    name: 'by_street_postal_code_country'
  end
end
