# Lets Make A Deal, Infinity Remix
Zack Tillotson

## Description

A money maximizing game where you are repeatedly given the choice to either take a chance to open a progressively more rewarding door with the progressively higher likelihood of losing your stash or pay a cost to reset the board (minimizing your likelihood of catastrophe but also your average reward). A level system is introduced in which the player can spend a relatively large amount of money to increase the average payoff of the doors.

Written in Javascript in order to be embedded on a website.

## Mechanics

### Open a door

Every turn the player is given the option to open the next door which can result in either a success or a failure. A success is the most likely outcome and gives the player a random reward which gets progressively higher as the player opens more doors. A failure is progressively more likely and will rob the player of all of their current money and give them one strike (an 'X').

### Reset level

Another option for a player is to reset the level's doors. This means the next door the player may open is again the lowest reward, lowest risk door.

### Move up a level

The final option for a player is to move up a level which does two things. First it makes the average reward from a door higher (higher level doors are more rewarding on average) and secondly it resets the strike count. This option costs a relatively large amount. 

### Falling down a level

If a player gets three strikes, in addition to losing all of their current money they also fall down a level.