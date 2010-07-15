require 'rubygems'
require 'mq'

AMQP.start do 

  logger = MQ.topic("logger")
  exceptions = MQ.queue("exceptions").bind("logger", :key=>"*.exception")
  events = MQ.queue("events").bind("logger", :key=>"events.#")
  all = MQ.queue("all").bind("logger", :key=>"#")
  logger.publish("MySQL has gone away", :key=>"login.exception")
  logger.publish("User: test login", :key=>"events.login")
  logger.publish("Upload: myphoto.png", :key=>"events.upload")
  exceptions.subscribe{ |msg| puts "Exception: #{msg}" }
  events.subscribe{ |msg| puts "Event: #{msg}" }
  all.subscribe{ |msg| puts "All: #{msg}" }

  Thread.new do
    sleep 5
    AMQP.stop { EM.stop }
  end
end
