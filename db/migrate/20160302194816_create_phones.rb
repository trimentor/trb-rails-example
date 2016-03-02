class CreatePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :phones do |t|
      t.belongs_to :person
      t.string  :telephone_number, null: false
      t.integer :telephone_type, default: 0
      t.integer :category, default: 0
    end
  end
end
