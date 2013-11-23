# Woorld

A simpel text-based adventure game.

## The Basics

Woorld is a text-based world filled with *people* (e.g. the player, other non-player characters), *places* (e.g. towns, buildings, rooms, vehicles), and *things* (wallet, laptop, money). All of these people, places, and things can potentially have actions (e.g. speak with person, enter building, use laptop.) For every action in Woorld there is a reaction (e.g. learn clue, lose money, win game).

You are a person. You start off in a place with some things. There is some action you must ultimately make to finish the game. Many intermediate actions must be carried out before the ultimate action. Certain actions require certain people, places, or things. Meeting these people, finding these things, and travelling to these places make up all of the things the player needs to do between first starting and finally finishing the game.

## Working with the Source

### Installation

Add this line to your application's Gemfile:

    gem 'woorld'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install woorld

### Run Tests

The tests are all written using 'minitest' and are located in the test/ directory. Run the tests with the following:

    $ bundle exec rake test

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
