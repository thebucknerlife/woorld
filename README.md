# Woorld

A simpel text-based adventure game.

## The Basics

### Game Pieces

- people
- places
- things
- actions
- reactions

### Generic Story

- You are a person.
- You start off in a place with some things.
- There is some action you must ultimately carry out that causes the win game reaction.
- Many intermediate actions must be carried out before the ultimate action. 
- Certain actions require certain people, places, or things.
- Meeting these people, finding these things, and travelling to these places make up all of the things the player needs to do between first starting and finally finishing the game.

### Mechanics

Mechanics:

- new game:
  - new world
    - build world
    - create people
    - create things
    - create places
    - add people to places
    - add things to places
  - new player
  - build player
    - name
  - add initial things to player
  - add player to initial place
- start game
  - greet player
- wait for player action
- process reaction
  - route action to correct person, place or thing and wait for reaction
  - route reaction to correct person, place, or thing
  - end game with end game reaction
- wait for player action ...

## Working with the Source

### Run Tests

The tests are all written using 'minitest' and are located in the test/ directory. Run the tests with the following:

    $ bundle exec rake test
