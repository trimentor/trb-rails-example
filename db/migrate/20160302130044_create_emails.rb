class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.belongs_to :person
      t.string  :address, null: false, index: true
      t.integer :category, default: 0, index: true
    end
  end
end
