require 'colorize'

#
# Objects
#

class Player

  def initialize(name)
    @name = name
    @inventory = []
  end

  def users_name
    @name
  end

  def add_to_inventory(thing)
    @inventory << thing
  end

  def has_in_inventory?(thing)
    @inventory.find { |obj| obj[:name] == thing }
  end

  def inventory_empty?
    @inventory.count == 0
  end

  def print_inventory_list
    puts
    if @inventory.empty?
      puts 'You have no things.'.red
    else
      @inventory.each do |thing|
        puts "  (#{thing[:id]}) #{thing[:name]}".light_blue
      end
    end
    puts
  end

end

class Place

  def initialize(things, paths, id, name)
    @things = things
    @paths = paths
    @id = id
    @name = name
  end

  def list_things_in_place
    @things.each do |thing|
      puts "  (#{thing[:id]}) #{thing[:name]}".light_blue
    end
  end

  def list_paths
    @paths.each do |path|
      puts "  (#{@id}) path to #{@name}".light_blue
    end
  end

end

#
# Game Properties
#

game_over = false

# new Player object
puts 'What is your name? (new object)'.yellow
user_input = gets.chomp

player = Player.new(user_input)
place1 = Place.new([{
      :id => 1,
      :name => 'safe',
      :takeable => false,
      :openable => true
    }], [{:id => 3}], 1, "Safe Room")

place2 = Place.new(nil, [{:id => 3}], 1, "Safe Room")

place3 = Place.new([{
      :id => 1,
      :name => 'safe',
      :takeable => false,
      :openable => true
    }], [{:id => 3}], 1, "Safe Room")

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
greeting = "Welcome to the adventure #{player.users_name.light_red}..."
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
    
    place.list_things_in_place
    place.list_paths

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
    
    player.add_to_inventory(thing)

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
    unless player.has_in_inventory?('safe key')
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
    player.print_inventory_list
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
