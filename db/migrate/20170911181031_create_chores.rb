class CreateChores < ActiveRecord::Migration[5.1]
  def change
    create_table :chores do |t|
    	t.string "title"
    	t.string "description"
    	t.integer "price", :limit => 8
      t.string "text_price"
      t.string "amount_as_string"
    	t.string "address"
    	t.references "userIDHiring"
      t.string "workRequest"
      	t.timestamps
    end
  end
end
