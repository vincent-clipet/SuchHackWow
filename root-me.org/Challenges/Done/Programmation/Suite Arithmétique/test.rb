
# Get page
html = `curl -i "http://challenge01.root-me.org/programmation/ch1/"`

# Split all lines from HTML code
html_lines = html.split("\n")

# We need to store cookie, or we'll get an error when submitting the answer
cookie = /.*(PHPSESSID=.*); path.*/.match(html_lines[7])[1]

# Regexes to match each needed value (a, b, U0, target)
line1_match_data = /.*\[ (-?[0-9]+) .* \] (.) \[ n \* (-?[0-9]+) \].*/.match(html_lines[12])
line2_match_data = /.* = (-?[0-9]+)/.match(html_lines[13])
line3_match_data = /.*<sub>(\d+)<\/sub>/.match(html_lines[14])

a = line1_match_data[1].to_i
sign = line1_match_data[2]
b = line1_match_data[3].to_i
u0 = line2_match_data[1].to_i
target = line3_match_data[1].to_i

if (sign == "-")
	reverse = -1
else
	reverse = 1
end



# Let's calc
result = u0
(1..target).each do | i |
	result = a + result + i * b * reverse
end

# Send response
html = `curl -H "Cookie: #{cookie}" "http://challenge01.root-me.org/programmation/ch1/ep1_v.php?result=#{result}"`

# Print flag
puts html