require 'sinatra'
require 'sinatra/reloader'


  num = rand(99)

get '/' do

  "The SECRET NUMBER is #{num}."
end
