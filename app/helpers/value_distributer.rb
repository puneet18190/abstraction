class ValueDistributer

	PERCENTAGE_FEES = 10


	def make_transactions(workOffer)
    	#Find out who invited the user that sends tx
	    # and who received the tx
	    #and then who invited the previous layers as well.

	    map = Hash.new

		r0 = User.find(workOffer.user_id)
    	r1 = find_user_that_invited(workOffer.user_id)
    	r2 = find_user_that_invited(r1.id)

    	left0 = findLeft(workOffer)
    	left1 = find_user_that_invited(left0.id)
    	left2 = find_user_that_invited(left1.id)

	    # Now you have all the info needed to generate a set of 
	    # transactions that distribute the gains
	    # according to the system
    	chore = workOffer.chore
    	price = chore.price
    	
    	toDistribute = price / 100 * PERCENTAGE_FEES

    	map["fees for L1"] = PERCENTAGE_FEES
    	map["to distribute"] = toDistribute
		map["for R1"] = (toDistribute / 2) * 70 / 100
		map["for R2"] = (toDistribute / 2) * 30 / 100
		map["for L1"] = (toDistribute / 2) * 70 / 100
		map["for L2"] = (toDistribute / 2) * 30 / 100
		map["for R0"] = price - toDistribute


		txR0 = Transaction.new(:from_user => left0.id, :to_user => r0.id, :amount => map["for R0"])
		txR1 = Transaction.new(:from_user => left0.id, :to_user => r1.id, :amount => map["for R1"])
		txR2 = Transaction.new(:from_user => left0.id, :to_user => r2.id, :amount => map["for R2"])
		txL1 = Transaction.new(:from_user => left0.id, :to_user => left1.id, :amount => map["for L1"])
		txL2 = Transaction.new(:from_user => left0.id, :to_user => left2.id, :amount => map["for L2"])

		txR0.save
		txR1.save
		txR2.save
		txL1.save
		txL2.save


		map["txR0"] = txR0
		map["txR1"] = txR1
		map["txR2"] = txR2
		map["txL1"] = txL1
		map["txL2"] = txL2

    	return map
	end


	def find_user_that_invited(user_id)
		user = User.find(user_id)
		if user.signup_code == "Support"
			return User.find(1)
		else
			return User.where(:invite_code => user.signup_code).first
		end
	end

	def findLeft(workOffer)
		chore = workOffer.chore
		user_id = chore.userIDHiring_id
		return User.find(user_id)
	end

	def percentage_fees
		result = PERCENTAGE_FEES
		return result
	end

end
