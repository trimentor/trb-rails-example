class CreateDomiciles < ActiveRecord::Migration[5.0]
  def change
    create_table :domiciles do |t|
      t.belongs_to :person
      t.belongs_to :address
    end
  end
end
