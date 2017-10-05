class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string "username"
      t.string "email"
      t.string "password"
      t.string "verify_email_code"
      t.boolean "is_email_verified"
      t.string "signup_code" 		#this is the code used when being invited by others
      t.string "invite_code"		#this is the code the user uses to invite others
      t.timestamps
    end
    
  end

  def up
    change_column :users, :is_email_verified, :boolean, default: false
  end

  def down
    change_column :users, :is_email_verified, :boolean, default: nil
  end

end
