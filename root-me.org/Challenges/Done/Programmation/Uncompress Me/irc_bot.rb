require 'cinch'
require 'base64'
require 'zlib'

class CinchPlugin

	include Cinch::Plugin
	
	listen_to :connect, :method => :on_connect
	listen_to :private, :method => :on_private
	
	@@anti_ban = 4



	def on_connect(m)
		User('Candy').send("!ep4")
	end



	def on_private(m)		
		if (@@anti_ban == 0) then exit(1) end # To avoid flooding CandyBot when flag is found, die after 3 responses
		@@anti_ban = @@anti_ban - 1

		u = m.user
		if (u.to_s == "Candy")
			compressed_data = Base64.decode64(m.message) # Decode message
			answer = Zlib::Inflate.inflate(compressed_data) # Uncompress
			u.send("!ep4 -rep #{answer}") # Send answer to server
			debug("[answer] Sent to bot : #{answer}")
		end
	end



	def uncompress(data)
		return Zlib::Inflate.inflate(data)
	end
	
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