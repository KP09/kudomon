# REQUIREMENTS

## Part 1
Implement three classes:
1) Position
attributes: position

2) Trainer < Position
attributes: name

3) Kudomon < Position
attributes: species, type
MUST be these species/types:
- Sourbulb -> grass
- Mancharred -> fire
- Chikapu -> electric
- Artikudo -> rock
- Charchomp -> psychic
- Kudoise -> water

Game is 2D
Square grid gets created
Player starts off at random position on the grid
Grid gets randomly populated with Kudomon and computer-Trainers
Player can indicate how far fwd/back and left/right they want to move

## Part 2
Trainer gets a collection attribute (empty array)
If there are any Kudomon close to the Trainer they don't have, they get notified
The Trainer can catch the Kudomon (add to collection)

## Part 3
Instead of saving the actual Kudomon thats being caught:
Just create a new Kudomon of the same type
The new Kudomon gets the same attribute values as the old one
Except position will be nil
Then many Trainers can catch the same Kudomon without any issue

## Part 4
Kudomon get HP and CP attributes
If there are computer Trainers close to the player, they get notified
The Trainer can choose to Battle a Trainer
The Trainer can choose which Kudomon they want to send into Battle
The computer Trainer Kudomon will be chosen at random
The first Kudomon to attack gets randomly selected
Some types are SUPER EFFECTIVE against others
They battle each other until one Kudomon's HP reaches 0
