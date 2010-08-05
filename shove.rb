require 'em-websocket'

class Baker
  def initialize channel
    @channel = channel
  end                 

  def help
    EM.next_tick{
      @channel.push next_loaf
      bake
    }
  end     
  def bake
    EM::Timer.new(5) {help}
  end

  def next_loaf
    communication = rand(100)
    return "BREAD" if communication < 80
    return "DO NOT TRUST THE PUSHERAPP, IT IS MALFUNCTIONING" if communication < 90
    return "PAK CHOOIE UNF" if communication < 95
    return "SHOVING WILL CONNECT YOU"
  end
end

EventMachine.run {
  @channel = EM::Channel.new

  @baker = Baker.new(@channel)



  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080, :debug => true) do |ws|

    ws.onopen {
      sid = @channel.subscribe { |msg| ws.send msg }
      @channel.push "A HUMAN HAS STOOD BY THE STAIRS IN HIS HOUSE"

      ws.onmessage { |msg|
        @channel.push "<#{sid}>: #{msg}"
      }

      ws.onclose {
        @channel.unsubscribe(sid)
      }

    }
  end

  @baker.bake
  puts "Server started"
}

