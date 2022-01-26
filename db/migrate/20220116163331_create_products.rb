class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.decimal :price, null: false, default: 0
      t.boolean :published, null: false, default: false
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
