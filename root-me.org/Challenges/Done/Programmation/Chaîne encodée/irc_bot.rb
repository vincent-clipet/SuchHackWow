require 'cinch'
require 'base64'

class CinchPlugin

	include Cinch::Plugin
	
	listen_to :connect, :method => :on_connect
	listen_to :private, :method => :on_private
	
	@@anti_ban = 4



	def on_connect(m)
		User('Candy').send("!ep2")
	end



	def on_private(m)		
		if (@@anti_ban == 0) then exit(1) end # To avoid flooding CandyBot when flag is found, die after 3 responses
		@@anti_ban = @@anti_ban - 1

		u = m.user
		if (u.to_s == "Candy")
			flag = Base64.decode64(m.message) # Decode message
			u.send("!ep2 -rep #{flag}") # Send response to server
			debug("[flag] Sent to bot : #{flag}")
		end
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