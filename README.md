# Kudomon GO!
Credit Kudos' Technical Challenge.

## How to play?
Start the game by running `ruby lib/app.rb`

You will be able to move around a virtual 2D grid. When there are Kudomon nearby you can catch them, but you can only have one of each Kudomon species with you. Each Kudomon has a set number of health points (HP) and combat points (CP). You can check out your Kudomon squad at any point. When there are other trainers nearby you can challenge one to a battle. You get to choose which of your Kudomon you want to send into battle, and your opponent's Kudomon will be randomly selected.

If you want to change any of the game's settings, you can do so in `lib/config.rb`

## Part 3: Some thoughts
When a Trainer comes across a Kudomon and decides to catch it, instead of catching that *actual* Kudomon instance they catch a copy of that Kudomon. A new Kudomon instance is created and added to their collection. That way a Kudomon can be caught many times, by the same Trainer over and over (although I have not allowed a Trainer to have more than one of a Kudomon species) or by multiple Trainers at the same time.

I have simplified a bit and instead of creating a copy of the *actual* Kudomon instance a Trainer comes across, I have just created a new Kudomon of that same species. That works fine in this app, because all Kudomon of a certain species are identical. If we allowed Kudomon of a certain species to be different (i.e. there is some random element to their HP/CP, or their properties change over time) then we would have to look at the *actual* instance itself to make an accurate copy.

Even if there were 10,000 people cramming into Central Park to catch the same Kudomon I think this concept would work, as there will never be more than one Trainer trying to update one instance. However, if we were working with a central database to store all Kudomon, (I think) we would need to add some sort of unique key to each Kudomon (maybe dependent on the Trainer's ID and a timestamp) so that no two records can be 100% identical.
