class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :name
      t.string :description
      t.string :picture

      t.timestamps null: false
    end
  end
end
