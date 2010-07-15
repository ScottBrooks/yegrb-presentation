require 'rubygems'
require 'mq'

AMQP.start do 

  exchange = MQ.direct("messages")
  server1 = MQ.queue("server1").bind("messages", :key=>"1")
  server2 = MQ.queue("server2").bind("messages", :key=>"2")
  exchange.publish("You can't hear me")
  exchange.publish("Server 1 Can", :key=>"1")
  exchange.publish("Server 2 Can", :key=>"2")
  server1.subscribe {|msg| puts "Server 1: #{msg}" }
  server2.subscribe {|msg| puts "Server 2: #{msg}" }

  Thread.new do
    sleep 5
    AMQP.stop { EM.stop } 
  end
end
