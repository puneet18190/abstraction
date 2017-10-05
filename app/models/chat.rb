class Chat < ApplicationRecord
	has_many :messages

	scope :search_u_A, lambda {|userA|
		where(["userA_id = ?", "#{userA}"])
	}
	scope :search_u_B, lambda {|userB|
		where(["userB_id = ?", "#{userB}"])
	}

	
end
