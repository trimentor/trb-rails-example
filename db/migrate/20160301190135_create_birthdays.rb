class CreateBirthdays < ActiveRecord::Migration[5.0]
  def change
    create_table :birthdays do |t|
      t.belongs_to :person, null: false
      t.belongs_to :event,  null: false
    end

    add_index :birthdays, [:person_id, :event_id], unique: true
  end
end
