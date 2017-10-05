class CreateWorkOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :work_offers do |t|
    	t.references "chore"
    	t.integer "user_id"
    	t.string "accept_offer_time"
    	t.string "work_complete_time"
    	t.string "work_complete_accepted_time"
	    t.timestamps
    end
  end
end
