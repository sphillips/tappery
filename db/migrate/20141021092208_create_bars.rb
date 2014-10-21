class CreateBars < ActiveRecord::Migration
  def change
    create_table :bars do |t|
    	t.string :name
    	t.string :address_1
    	t.string :address_2
    	t.string :city
    	t.string :state
    	t.string :zip
    	t.text :description
    	t.integer :location_id
    	t.string :phone
    	t.string :twitter
    	t.string :facebook
    	t.string :mon_special
    	t.string :tue_special
    	t.string :wed_special
    	t.string :thu_special
    	t.string :fri_special
    	t.string :sat_special
    	t.string :sun_special
      t.timestamps
    end
  end
end
