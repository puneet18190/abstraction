class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
    	t.integer "from_user"
    	t.integer "to_user"
    	t.integer "amount", :limit => 8
    	t.string "text_amo"
    	t.timestamps
    end
  end
end
