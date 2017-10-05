class CreateWithdrawalRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :withdrawal_requests do |t|
    	t.string "userID"
		  t.integer "amount", :limit => 8
      t.string "text_amo"
      t.string "information"
      t.string "type"
      t.string "processed_time"

      t.timestamps
    end
  end
end
