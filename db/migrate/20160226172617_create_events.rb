class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :location
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.text :description
      t.timestamps
    end
  end
end
