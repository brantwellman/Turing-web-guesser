require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(100)
get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  erb :index, :locals => {:message => message}
end

def check_guess(guess)
  guess = guess.to_i
  secret_num = settings.secret_number
  if guess > secret_num
    (guess - 5 > secret_num) ? message = "Woah! That is waaay to high!" : message = "So sorry. Your guess is too high"
  elsif guess < secret_num
    guess + 5 < secret_num ? message = "Hey now. You are guessing waay too low!" : message = "Nope. That guess is too low"
  elsif secret_num == guess
    message = "Congrats! You beat the number guesser! The secret number is #{secret_num}"
  end
end
