# Open Door, The Game
Zack Tillotson

## Description

A money maximizing game where you are presented with a number of doors which can be opened. Behind each door is either a monitary reward or a Strike. If you reach your Strike limit then:

1. You lose a life 
2. The doors reset 
3. The strikes reset 
4. You go down a level. 

If you successfully open enough doors however 

1. You reset the strike count 
2. Gain all of the monitary rewards 
3. The doors all reset
4. You go up a level which makes the average door reward higher. 

One last option is to pay a cost to force the board to reset.

Written in Javascript in order to be embedded on a website. Technologies include ReactJS, UnderscoreJS, Gulp, NodeJS, and Jasmine.

## Mechanics

### Open a door

Every level the player is presented with a set of doors. Each door shows a hint of how likely the door is to be successfully opened. A success is generally the most likely outcome and shows the player what their reward will be if they are able to complete the level. A failure will give the player a Strike.

### Reset level

An option for a player is to reset the level. This will close all open doors and randomize all doors, so therefore the Strikes reset and the rewards are given up.

### Moving up a level

When the user is able to achieve the required open door count they win the level! All revealed rewards are combined and given to the user. Any Strikes are removed. A higher level's rewards are higher on average than a lower levels but also the average risk of failure is higher.

### Losing a life

If a player gets too many Strikes you fall down a level and lose a life. After three lives are lost the game is over.
