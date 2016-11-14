lines = File.readlines("obfuscated.txt")

lines.each do | line |
	ops = line.split("+")

	ops.each do | op |
		tmp = op.split("x")

		if (tmp[0] == "0")
			print(" "*tmp[1].to_i)
		else
			print("*"*tmp[1].to_i)
		end
	end

	puts
end