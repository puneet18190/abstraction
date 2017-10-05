class CreateInvites < ActiveRecord::Migration[5.1]
  def change
    create_table :invites do |t|
    	t.integer "user_id"
    	t.string "invite_code"
    	t.string "title"
    	t.string "comment"
      	t.timestamps
    end
  end
end
