class CreateUserActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :user_activities do |t|
    	t.string "activity_name"
    	t.integer "user_id"

      t.timestamps
    end
  end
end
