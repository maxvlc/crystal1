require "kemal"
require "kemal-session"

Kemal::Session.config.cookie_name = "kemal_session_id"
Kemal::Session.config.secret = "63e071954192ed9e3fbe31574452a84b"
Kemal::Session.config.gc_interval = 2.minutes # 2 minutes

before_get "/" do |env|
  env.set "is_kemal_cool", true
end

get "/" do |env|
  is_kemal_cool = env.get "is_kemal_cool"
  "Kemal cool = #{is_kemal_cool} - Hello World!"
end

get "/set" do |env|
  env.session.int("number", rand(100)) # set the value of "number"
  "Random number set."
end

get "/get" do |env|
  num  = env.session.int("number") # get the value of "number"
  env.session.int?("hello") # get value or nil, like []?
  "Value of random number is #{num}."
end

Kemal.run
