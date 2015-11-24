require 'sinatra'
require 'sinatra/reloader'

@@remaining_guesses = 5
@@secret_number = rand(100)
# set :secret_number, rand(100)
get '/' do
  guess = params["guess"]
  guess_mess = guess_count(guess)
  message = check_guess(guess) + guess_mess
  color = background_color(message)
  erb :index, :locals => {:secret_number => @@secret_number, :message => message, :color => color, :guess => guess}
end

def guess_count(guess)
  @@remaining_guesses -= 1 unless guess.nil?
  if @@remaining_guesses == 0
    start_over
    " Sorry, you ran out of guesses. A new number has been generated for you to guess"
  else
    ""
  end
end

def start_over
  @@remaining_guesses = 5
  @@secret_number = rand(100)
  # set :secret_number, rand(100)
end

def check_guess(guess)
  return "Please provide a number." if guess.nil?
  guess = guess.to_i
  # secret_num = settings.secret_number
  if guess > @@secret_number
    (guess - 5 > @@secret_number) ? "Woah! That is waaay too high!" + guesses_left : "Sorry. Your guess is too high" + guesses_left
  elsif guess < @@secret_number
    guess + 5 < @@secret_number ? "Hey now. That is waaay too low!" + guesses_left : "Sorry. That guess is too low" + guesses_left
  elsif @@secret_number == guess
    start_over
    "Congrats! You beat the number guesser! The secret number is #{@@secret_number}.\nThe secret number has been reset. Try again." + guesses_left
  end
end

def guesses_left
  " You have #{@@remaining_guesses} guesses left."
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
