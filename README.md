# Open Door: A Game of Risk
Zack Tillotson

## Description

A money maximizing game where you are presented with a number of doors which can be opened. Behind each door is either a Check and a monitary value or Strike. Three checks and you collect the total money shown and increase your level. Three strikes and you lose a life and decrease your level. Higher levels increase the average door value and likelyhood of a Strike. Open doors until you go up or down a level, or pay to reset the board (close the doors and re-randomize them). To get a high score you will need to optimize your actions for the risk presented.

## Installation

```
npm install
gulp
node server.js
```
Then use a modern browser to navigate to http://localhost:3000/

## Mechanics Detail

In designing this game I was interested in somethign which could achieve three goals. First I wanted to write a purely client side application. Second I wanted to write something which could serve as a vehicle to learn and teach machine learning techniques. Third I wanted it to be both simple to learn but complex enough to be interesting. I was originally inspired by the Multi Armed Bandit and Montey Hall problems, but the design evolved into something a bit different over time. This is a brief description of some of the design decisions.

### Open a door

Every level the player is presented with a set of doors. Each door shows a hint of how likely the door is to be successfully opened. A success is generally the most likely outcome and shows the player what their reward will be if they are able to complete the level. A failure will give the player a Strike.

### Reset level

An option for a player is to reset the level. This will close all open doors and randomize all doors, so therefore the Strikes reset and the rewards are given up.

### Moving up a level

When the user is able to achieve the required open door count they win the level! All revealed rewards are combined and given to the user. Any Strikes are removed. A higher level's rewards are higher on average than a lower levels but also the average risk of failure is higher.

### Losing a life

If a player gets too many Strikes you fall down a level and lose a life. After three lives are lost the game is over.


### Etc

Written in pure Javascript in order to be embedded on a website. Technologies include ReactJS (!), jQuery with some plugins, UnderscoreJS, Gulp, NodeJS, FirebaseJS, and Jasmine.