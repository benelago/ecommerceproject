class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.references :guntype, null: false, foreign_key: true
      t.references :quality, null: false, foreign_key: true

      t.timestamps
    end
  end
end
