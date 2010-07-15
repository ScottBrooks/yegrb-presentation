require 'rubygems'
require 'mq'

AMQP.start do 

  exchange = MQ.fanout("alerts")
  server1 = MQ.queue("server1").bind("alerts")
  server2 = MQ.queue("server2").bind("alerts")
  exchange.publish("The sky is falling!")
  server1.subscribe do |msg|
    puts "Server 1: #{msg}"
  end
  server2.subscribe do |msg|
    puts "Server 2: #{msg}"
  end

  Thread.new do
    sleep 5
    AMQP.stop { EM.stop } 
  end
end
