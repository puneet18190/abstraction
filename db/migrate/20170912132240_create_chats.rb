class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
    	t.integer "userA_id"
    	t.integer "userB_id"
    	t.integer "userA_lastViewTime"
    	t.integer "userB_lastViewTime"
      	t.timestamps
    end
  end
end
