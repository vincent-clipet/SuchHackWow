#!/usr/bin/env ruby

require 'socket'

class SimpleIrcBot

  def initialize(server, port, channel)
    @channel = channel
    @socket = TCPSocket.open(server, port)
    say "/NICK Hannibot"
    say "/USER hannibot 0 * Hannibot"
    say "/JOIN #{@channel}"
    say "Test"
  end

  def say(msg)
    puts msg
    @socket.puts msg
  end


  def query(msg, username)
    say "/QUERY #{username} #{msg}"
  end

  def quit
    say "/PART #{@channel}"
    say '/QUIT'
  end



  def run
    query("!ep2", "Candy")
    resp = @socket.gets
    puts ">> #{resp}"
    quit()
  end

end

bot = SimpleIrcBot.new("irc.root-me.org", 6667, '#root-me_challenges')
trap("INT"){ bot.quit }
bot.run()


