require 'rubygems'
require 'mq'

AMQP.start do 

  exchange = MQ.direct("logs")
  queue = MQ.queue("everything")
  exchange.publish("test message")
  puts "You will have to hit ctrl-C here, since we won't get a message"
  queue.subscribe do |msg|
    puts msg
    AMQP.stop { EM.stop } 
  end

end
