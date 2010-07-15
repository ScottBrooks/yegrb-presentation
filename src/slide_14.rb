require 'rubygems'
require 'mq'

AMQP.start do 

  exchange = MQ.direct("logs")
  queue = MQ.queue("everything").bind("logs")
  exchange.publish("test message")
  queue.subscribe do |msg|
    puts msg
    AMQP.stop { EM.stop } 
  end

end
