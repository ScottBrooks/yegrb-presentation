require 'rubygems'
require 'mq'

AMQP.start do 

  exchange = MQ.direct("logs")
  exchange.publish("test message")

  AMQP.stop{ EM.stop }
end
