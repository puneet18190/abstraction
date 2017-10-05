require 'test_helper'

class ConverterTest < ActionDispatch::IntegrationTest
  

  #============ test from string to integer=================
  test "shouldConvertFromStringToInt" do
  	con = Converter.new
  	res = con.to_int("50.0")
  	expected = 500000000000
    assert res == expected
  end


	test "shouldHandleSomeDecimals" do
	  	con = Converter.new
	  	res = con.to_int("50.1")
	  	expected = 501000000000
	    assert res == expected
	end


	test "shouldHandleDotAndNoNumber" do
	  	con = Converter.new
	  	res = con.to_int("50.")
	  	expected = 500000000000
	    assert res == expected
	end

	test "shouldHandleManyDecimals" do
	  	con = Converter.new
	  	res = con.to_int("50.10025")
	  	expected = 501002500000
	    assert res == expected
	end


	test "shouldHandleManyNumbersBeforeDecimals" do
	  	con = Converter.new
	  	res = con.to_int("5150.1")
	  	expected = 51501000000000
	    assert res == expected
	end

	test "shouldHandleNothingBeforeDot" do
	  	con = Converter.new
	  	res = con.to_int(".1248711124")
	  	expected = 1248711124
	    assert res == expected
	end


	test "shouldHandleManyZerosAtStart" do
	  	con = Converter.new
	  	res = con.to_int(".0000011124")
	  	expected = 11124
	    assert res == expected
	end

	test "shouldHandleManyBeforeDotAndAfterDot" do
	  	con = Converter.new
	  	res = con.to_int("49000000.1248711124")
	  	expected = 490000001248711124
	    assert res == expected
	end

	test "shouldHandleNoDot" do
	  	con = Converter.new
	  	res = con.to_int("49000000")
	  	expected = 490000000000000000
	    assert res == expected
	end


	test "shouldHandleTooManyDecimals" do
	  	con = Converter.new
	  	res = con.to_int("0.123456789012345678")
	  	expected = 1234567890
	    assert res == expected
	end


	test "shouldHandleTooManyDecimalsOnBigNumbers" do
	  	con = Converter.new
	  	res = con.to_int("49000000.123456789012345678")
	  	expected = 490000001234567890
	    assert res == expected
	end




#============ test from integer to string =================

	test "shouldHandleSmallNumber" do
	  	con = Converter.new
	  	res = con.to_string(123456789)
	  	expected = "0.0123456789"
	    assert res == expected
	end


	test "shouldHandleVerySmallNumber" do
	  	con = Converter.new
	  	res = con.to_string(55)
	  	expected = "0.0000000055"
	    assert res == expected
	end

	test "shouldHandleExactly_1_netal" do
	  	con = Converter.new
	  	res = con.to_string(10000000000)
	  	expected = "1.0000000000"
	    assert res == expected
	end


	test "shouldHandleMoreThan_1_netal" do
	  	con = Converter.new
	  	res = con.to_string(210000000000)
	  	expected = "21.0000000000"
	    assert res == expected
	end

	test "shouldHandleMoreThan_1_netalManyDecimals" do
	  	con = Converter.new
	  	res = con.to_string(212345678901)
	  	expected = "21.2345678901"
	    assert res == expected
	end

	test "shouldHandleVeryBigNumberWithManyDecimals" do
	  	con = Converter.new
	  	res = con.to_string(490000001234567890)
	  	expected = "49000000.1234567890"
	    assert res == expected
	end

end
