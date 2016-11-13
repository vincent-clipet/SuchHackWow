require 'cinch'

class CinchPlugin

	include Cinch::Plugin
	
	listen_to :connect, :method => :on_connect
	listen_to :private, :method => :on_private
	


	def on_connect(m)
		User('Candy').send("!ep1")
	end



	def on_private(m)

		u = m.user

		if (u.to_s == "Candy")

			regex_match = /([0-9]+) \/ ([0-9]+)/.match(m.message)
			
			if (regex_match.nil?) # Flag ?
				debug("[flag] Message from bot : #{m.message}")
			else # Numbers
				total = (Math::sqrt(regex_match[1].to_i) * regex_match[2].to_i).round(2)
				u.send("!ep1 -rep #{total}")
				debug("[numbers] Total sent to bot : sqrt(#{a}) * #{b} = #{total}")
			end
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