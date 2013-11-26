require 'colorize'

#
# Game Properties
#

game_over = false

# new player
player = {
  :name => '',
  :inventory => [],
}
puts 'What is your name?'.yellow
player[:name] = gets.chomp
puts

# new place
places = [{
    :id => 1,
    :name => 'Safe Room',
    :things => [{
      :id => 1,
      :name => 'safe',
      :takeable => false,
      :openable => true
    }],
    :paths => [{:id => 3}]
  }, {
    :id => 3,
    :name => 'Hallway',
    :things => [],
    :paths => [{:id => 2}, {:id => 1}]
  }, {
    :id => 2,
    :name => 'Key Room',
    :things => [{
      :id => 2,
      :name => 'safe key',
      :takeable => true,
      :openable => false
    }],
    :paths => [{:id => 3}]
}]

# greet player
greeting = "Welcome to the adventure #{player[:name].light_red}..."
puts '='.black * greeting.length
puts greeting.black
puts '='.black * greeting.length
puts 'To win the game:'.green
puts '- Open the safe.'.light_green
puts

# set current_place
current_place = places[0]

#
# Game Loop
#

until game_over do
  # wait for player action
  puts 'What do you want to do?'.yellow
  puts '"?" or "help" for a list of available actions'.black
  action = gets.chomp

  # react to action
  case action
  when 'look'
    puts
    puts "You're in \"#{current_place[:name]}\" and you see:".blue
    current_place[:things].each do |thing|
      puts "  (#{thing[:id]}) #{thing[:name]}".light_blue
    end
    current_place[:paths].each do |path|
      place = places.find { |place| place[:id] == path[:id] }
      puts "  (#{place[:id]}) path to #{place[:name]}".light_blue
    end
    puts
  when /take \d+/
    thing_id = action.match(/take (\d+)/).captures.first.to_i
    thing = current_place[:things].find { |thing| thing[:id] == thing_id }
    unless thing
      puts
      puts "Thing with id #{thing_id} does not exist.".red
      puts
      next
    end
    unless thing[:takeable]
      puts
      puts "#{thing[:name]} cannot be taken.".red
      puts
      next
    end

    current_place[:things].delete thing
    player[:inventory] << thing

    puts
    puts "Added #{thing[:name]} to your inventory".light_green
    puts
  when /open \d+/
    thing_id = action.match(/open (\d+)/).captures.first.to_i
    thing = current_place[:things].find { |thing| thing[:id] == thing_id }
    unless thing
      puts
      puts "Thing with id #{thing_id} does not exist.".red
      puts
      next
    end
    unless thing[:openable]
      puts
      puts "#{thing[:name]} is not openable.".red
      puts
      next
    end
    unless player[:inventory].find { |thing| thing[:name] == 'safe key' }
      puts
      puts "(#{thing[:name]}) requires safe key".light_red
      puts
      next
    end

    # end the game
    game_over = true
    puts
    puts 'Congratulations! You have won!'.green
    puts
  when /goto \d+/
    place_id = action.match(/goto (\d+)/).captures.first.to_i
    place = places.find { |place| place[:id] == place_id }
    unless place
      puts
      puts "Place with id #{place_id} does not exist.".red
      puts
      next
    end
    unless current_place[:paths].find { |path| path[:id] == place_id }
      puts
      puts "Cannot get to place #{place_id} from #{current_place[:name]}.".red
      puts
      next
    end
    current_place = place
    puts
    puts "Now in #{current_place[:name]}".light_green
    puts
  when 'inventory'
    puts
    if player[:inventory].count == 0
      puts 'You have no things.'.red
    else
      player[:inventory].each do |thing|
        puts "  (#{thing[:id]}) #{thing[:name]}".light_blue
      end
    end
    puts
  when /help|\?/
    puts
    puts 'Here are the things you can do:'.light_cyan
    puts '  look - describe surroundings'.light_cyan
    puts '  take <thing #> - remove thing from place and add to inventory'.light_cyan
    puts '  open <thing #> - opens an openable thing'.light_cyan
    puts '  goto <place #> - moves the player around'.light_cyan
    puts '  inventory - lists all of the things you have'.light_cyan
    puts '  help or ? - print this message'.light_cyan
    puts
  else
    puts "#{action} is an invalid action".red
    puts 'run help or ? for a list of available actions'.light_red
    puts
  end
end
