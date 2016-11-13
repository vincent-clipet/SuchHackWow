require 'cinch'
require 'base64'

class CinchPlugin

	include Cinch::Plugin
	
	listen_to :connect, :method => :on_connect
	listen_to :private, :method => :on_private
	
	@@anti_ban = 4



	def on_connect(m)
		User('Candy').send("!ep3")
	end



	def on_private(m)		
		if (@@anti_ban == 0) then exit(1) end # To avoid flooding CandyBot when flag is found, die after 3 responses
		@@anti_ban = @@anti_ban - 1

		u = m.user
		if (u.to_s == "Candy")
			answer = get_rot13(m.message)
			u.send("!ep3 -rep #{answer}") # Send answer to server
			debug("[answer] Sent to bot : #{answer}")
		end
	end



	@@rot13_index = {}

	# Build a hash with 26x2 indexes
	# hash["a"] = "n"
	# hash["A"] = "N"
	def self.init_rot13_index()

		alphabet = ("a".."z").to_a
		(0..26).each { |i| @@rot13_index[alphabet[i]] = alphabet[(i+13) % 26] } # Add lowercase letters to hash

		alphabet = ("A".."Z").to_a
		(0..26).each { |i| @@rot13_index[alphabet[i]] = alphabet[(i+13) % 26] } # Add uppercase letters to hash

		numbers = ("0".."9").to_a
		(0...10).each { |i| @@rot13_index[numbers[i]] = numbers[i] } # Add numbers to hash, without ROT13-ing them
	end

	def get_rot13(str)
		ret = ""
		str.split("").each do | char |
			ret += @@rot13_index[char]
		end
		return ret
	end

	CinchPlugin::init_rot13_index()


	
end



bot = Cinch::Bot.new do
	configure do |c|
		c.server = "irc.root-me.org"
		c.channels = ["#root-me_challenge"]
		c.nick = "CinchBot"
		c.plugins.plugins = [CinchPlugin]
	end
end

bot.start()