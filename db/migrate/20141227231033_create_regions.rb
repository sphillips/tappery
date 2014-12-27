class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.integer :state_id

      t.timestamps
    end
    add_index :regions, :state_id
  end
end
