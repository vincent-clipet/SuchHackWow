require 'base64'

# Log file from challenge
input = File.readlines("ch13.txt")


# Seconds from last request
last_seconds = 0

# Used to store 8-bits from current letter of password
buffer = ""



input.each.with_index do | line, line_number |

	# Clean lines to only get Time & Base64 string
	line = line.gsub(/ HTTP\/1.1.*/, "")
	line = line.gsub(/\+0200.*order=/, "")
	line = line.gsub(/.*Jun\/2015:/, "")

	split = line.split(" ")

	# Decoded Base64 string
	base64_decoded = Base64.decode64(split[1])

	# Time from current request	
	time = split[0]
	
	# Seconds from current request	
	seconds = time.split(":")[2].to_i

	# time spent by last request
	delta = (seconds - last_seconds) % 60
	last_seconds = seconds



	# 1st, 2nd or 3rd request (6 bits)
	if (line_number % 4 != 0)
		if (delta == 0)
			buffer << "00"
		elsif delta == 2
			buffer << "01"
		elsif delta == 4
			buffer << "10"
		elsif delta == 6
			buffer << "11"
		end

	# 4th request (2 bits)
	else
		# Request failed because current char is only 6-bits long.
		# Left-pad with "00", to reach 8-bits
		if (delta == 0)
			buffer.insert(0, "00")

		# Left-pad with "0", to reach 8-bits
		elsif (delta == 2)
			buffer << "0"
			buffer.insert(0, "0")

		# Left-pad with "0", to reach 8-bits
		elsif delta == 4
			buffer << "1"
			buffer.insert(0, "0")
		end

		# End of buffer reached (8-bits), print it and clean it for next character
		print(buffer.to_i(2).chr())
		buffer = ""
	end

end
