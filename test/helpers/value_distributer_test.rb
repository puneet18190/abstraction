require 'test_helper'

class ConverterTest < ActionDispatch::IntegrationTest
  

  test "shouldFindCorrect_R1_user" do

  	user_R2 = User.new(:username => "Lina", :signup_code => "Support", :invite_code => "L2Code")
  	user_R2.save

  	user_R1 = User.new(:username => "Jim", :signup_code => "L2Code", :invite_code => "L1Code")
  	user_R1.save

  	user_R0 = User.new(:username => "Cody", :signup_code => "L1Code", :invite_code => "L0Code")
  	user_R0.save


  	dist = ValueDistributer.new
  	levelUp = dist.find_user_that_invited(user_R0.id)
  	
    assert levelUp.username == "Jim"

  end


  test "shouldProduceCorrectAmountsForEachActor" do

  	user_R2 = User.new(:username => "Lina", :signup_code => "Support", :invite_code => "R2Code")
  	user_R2.save

  	user_R1 = User.new(:username => "Jim", :signup_code => "R2Code", :invite_code => "R1Code")
  	user_R1.save

  	user_R0 = User.new(:username => "Cody", :signup_code => "R1Code", :invite_code => "R0Code")
  	user_R0.save

  	
  	user_L2 = User.new(:username => "Left2", :signup_code => "Support", :invite_code => "L2Code")
  	user_L2.save

  	user_L1 = User.new(:username => "Left1", :signup_code => "L2Code", :invite_code => "L1Code")
  	user_L1.save

  	user_L0 = User.new(:username => "Left0", :signup_code => "L1Code", :invite_code => "L0Code")
  	user_L0.save


  	chore = Chore.new(:title => "Wash", :price => 200, :userIDHiring_id => user_L0.id)
  	chore.save

  	offer = WorkOffer.new(:chore_id => chore.id, :user_id => user_R0.id)
  	offer.save

  	dist = ValueDistributer.new
  	map = dist.make_transactions(offer)
  	

    assert map["to distribute"] == 20

    assert map["for L1"] == 7
    assert map["for L2"] == 3
    assert map["for R1"] == 7
    assert map["for R2"] == 3
  end



  test "shouldGenerateCorrectTransactions" do

  	user_R2 = User.new(:username => "Lina", :signup_code => "Support", :invite_code => "R2Code")
  	user_R2.save

  	user_R1 = User.new(:username => "Jim", :signup_code => "R2Code", :invite_code => "R1Code")
  	user_R1.save

  	user_R0 = User.new(:username => "Cody", :signup_code => "R1Code", :invite_code => "R0Code")
  	user_R0.save

  	
  	user_L2 = User.new(:username => "Left2", :signup_code => "Support", :invite_code => "L2Code")
  	user_L2.save

  	user_L1 = User.new(:username => "Left1", :signup_code => "L2Code", :invite_code => "L1Code")
  	user_L1.save

  	user_L0 = User.new(:username => "Left0", :signup_code => "L1Code", :invite_code => "L0Code")
  	user_L0.save


  	chore = Chore.new(:title => "Wash", :price => 200, :userIDHiring_id => user_L0.id)
  	chore.save

  	offer = WorkOffer.new(:chore_id => chore.id, :user_id => user_R0.id)
  	offer.save

  	dist = ValueDistributer.new
  	map = dist.make_transactions(offer)
  	

 # 	  t.integer "from_user"
 #    t.integer "to_user"
 #    t.bigint "amount"
 #    t.string "text_amo"


    assert map["txL1"].from_user = user_L0.id
    assert map["txL1"].to_user = user_R1.id
    assert map["txL2"].to_user = user_L2.id
    assert map["txR2"].amount == 3

    # assert map["txL1"].from_user = user_L0.id
    # assert map["txL1"].from_user = user_L0.id

    # assert map["tx L2"] == 3
    # assert map["tx R1"] == 7
    # assert map["tx R2"] == 3
  end


end