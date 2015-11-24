require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(100)
get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  color = background_color(message)
  erb :index, :locals => {:message => message, :color => color, :guess => guess}
end

def check_guess(guess)
  if guess.nil?
    return message = "Please provide a number."
  end
  guess = guess.to_i
  secret_num = settings.secret_number
  if guess > secret_num
    (guess - 5 > secret_num) ? message = "Woah! That is waaay too high!" : message = "Sorry. Your guess is too high"
  elsif guess < secret_num
    guess + 5 < secret_num ? message = "Hey now. That is waaay too low!" : message = "Sorry. That guess is too low"
  elsif secret_num == guess
    message = "Congrats! You beat the number guesser! The secret number is #{secret_num}"
  end
end

def background_color(message)
  if message.split.include?("waaay")
    "#E33512"
  elsif message.split.include?("Sorry.")
    "#FCA395"
  elsif message.split.include?("Congrats!")
    "#169E1B"
  elsif message.split.include?("Please")
    "#A3C9CF"
  end
end
