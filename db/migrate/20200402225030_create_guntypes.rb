class CreateGuntypes < ActiveRecord::Migration[6.0]
  def change
    create_table :guntypes do |t|
      t.string :gunshottype

      t.timestamps
    end
  end
end
