class Converter 

	def to_i(asString)
		return to_int(asString)
	end
	
	def to_int(asString)
		if asString.nil?
			return 0
		end
		
		if asString.index('.')
			while charsToRightOfComma(asString) < 10 do 
				asString += "0"
			end

			while charsToRightOfComma(asString) > 10 do 
				asString = asString[0...-1]
			end

			commaRemoved = asString.tr('.', '')

			int = commaRemoved.to_i

			return int
		else
			withDot = asString + ".0"
			return to_int(withDot)
		end

	end

	def charsToRightOfComma(theWholeString)
		i = theWholeString.index('.')
		length = theWholeString.length
		toRightOfComma = length - i -1
		return toRightOfComma
	end

	def to_s(theInteger)
		return to_string(theInteger)
	end

	def to_string(theInteger)
		result = ""
		if theInteger < 10000000000
			conv = theInteger.to_s

			while conv.length < 10
				conv = "0" + conv
			end
			result = "0." + conv
		end

		if theInteger >= 10000000000
			conv = theInteger.to_s
			flipped = conv.reverse
			backChars = flipped[0..9]
			frontChars = flipped[10..flipped.length]

			fullReversed = backChars + "." + frontChars
			
			result = fullReversed.reverse
		end
		return result
	end

end
