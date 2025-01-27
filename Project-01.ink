/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

VAR strength  = 5
VAR intelligence = 1
VAR pet_name = ""
VAR torches = 0
VAR coins = 0

VAR time = -1 
VAR keys = 0
VAR pet_type = ""

-> memory

== memory ==
Before you stands the cavern of Josh. You wish your childhood pet was with you right now. The cave might be less intimidating then. What was your pet's name?

* [Charlie]
    ~ pet_name = "Charlie"
    -> cave_mouth
* [Susan]
    ~ pet_name = "Susan"
    -> cave_mouth
* [Spot]
    ~ pet_name = "Spot"
    ->cave_mouth

== cave_mouth ==
You are at the enterance to a cave. It is {advance_time()}. {not torch_pickup:There is a torch on the floor.} {The cave extends to the east and west. You made it to the cave. If only {pet_name} could see you now. |}

You have {torches} torches.


+ [Take the east tunnel] -> east_tunnel
+ [Take the west tunnel] -> west_tunnel
* [Pick up the torch] -> torch_pickup
+ [Take a break and go to the market] -> market

== east_tunnel ==
{&You are in the east tunnel.|You travel down the east tunnel again.|You walk through the east tunnel} {not east_tunnel_lit:It is very dark, you can't see anything. | } {not torch_pickup:You do not have a torch. You should pick one up first. | }
* {torches > 0} [Light Torch] -> east_tunnel_lit
+ {east_tunnel_lit} [Look Around] -> east_tunnel_lit
+ [Go Back to the Cave Mouth] -> cave_mouth
-> END

== west_tunnel ==
{&You are in the west|You travel down the west tunnel again.|You walk through the west tunnel.}
{pet_name == "Spot" : Spot would love it here in the west| }
+ [Continue Forward] { - push_boulder_succeed: 
			-> push_boulder_treasure
		- else:
			-> west_tunnel_boulder
	}
+ [Go Back to the Cave Mouth] -> cave_mouth
-> END

=== torch_pickup ===
~ torches = torches + 1
You now have a torch. May it light the way.
* [Go Back to the Cave Mouth] -> cave_mouth
-> END

=== potion_pickup ===
~ strength = strength + 2
~ intelligence = intelligence + 2
~ coins = coins + 5
You consume the magical potion. You already feel it working! You now have {strength} strength and {intelligence} intelligence. You also have {coins} coins.
+ [Go Back to the Cave Mouth] -> cave_mouth
-> END

== east_tunnel_lit ==
{You walk farther down the east tunnel. The light of your torch glints off of the treasures in the room. There are various potions, jewelery, and coins scattered on the ground. Some of which are covered by dirt and debris. |You walk farther down the east tunnel. }
* [Pick up a potion.] -> potion_pickup
+ [Search the area for more treasures.] -> east_tunnel_lit_chest
+ [Go Back] -> cave_mouth
-> END

== east_tunnel_lit_chest ==
{key_chest: You see the chest you already opened. | You search the room and see a large silver chest. It is locked.} 
* {keys > 0} [Use the key to open the chest.] -> key_chest
+ {key_chest} [Examine the chest again] -> examine_chest
* {not key_chest} [Try to pry the chest open] -> pry_chest
* {intelligence > 2} [Try picking the lock] -> key_chest
+ [Go Back to the Cave Mouth] -> cave_mouth
-> END

== key_chest ==
You succeed in opening the chest. Inside the chest are many gold coins and numerous potions. It is only {advance_time()} and you have already found much treasure!

* [Pick up a potion and take the coins.] -> potion_pickup
+ [Go Back to the Cave Mouth] -> cave_mouth
-> END

== examine_chest ==
{&You already collected the items from this chest.|There is nothing else to collect.|The empty chest is not very interesting.} You shouldn't waste your time looking at an empty chest, it is already {advance_time()}!

+ [Continue to explore this area] -> east_tunnel_lit
+ [Go Back to the Cave Mouth] -> cave_mouth
-> END

== pry_chest == 
You try to pry the chest open. It does not budge. You might need to find the key instead.
+ [Go back and try somthing else] -> east_tunnel_lit_chest
+ [Go Back to the Cave Mouth] -> cave_mouth
-> END


== west_tunnel_boulder == 
{You continue forward, feeling hopeful you will encounter treasures. However, you run into a boulder that is blocking the tunnel.|There is a boulder that is blocking the tunnel.} 

* {not push_boulder_succeed && strength > 5} [Try to Push the boulder out of the way.] -> push_boulder_succeed
* [Use your hands to dig a tunnel around the boulder.] -> boulder_fail
* [Try to squeeze by.] -> boulder_death
-> END

== push_boulder_succeed ==
You have {strength} strength. You gather enough strength to push the boulder out of the way. It rolls slowly but after much effort, you succeed! But it took quite a bit of time to move the boulder--it is already {advance_time()}.

You can see the treasure that lies ahead.
+ [Go look at the treasure.] -> push_boulder_treasure
-> END

== boulder_fail ==
You try to dig around the boulder but your hands are not an efficent tool. You'll have to try something else.
+ [Try somthing else] -> west_tunnel_boulder
-> END

== boulder_death ==
You squeeze you body into the crevice where the cave wall and the boulder met. Unfortunetly, it's too small and you can barely move. You try to get out but you find that you're trapped in the crevice. You yell for help but no one can hear. You die after a few days.
-> END


== push_boulder_treasure == 
{You reach the end of the west tunnel. The are many coins and potions scatterred around.| You reach the end of the west tunnel.} {not key_pickup: As you turn to leave, you notice a shiny key on the floor. | } 
* [Pick up the key.] -> key_pickup
* [Pick up the coins and potions.] -> potion_pickup
+ [Go Back to the Cave Mouth] -> cave_mouth
-> END

== key_pickup ==
~ keys = keys + 1
You now have {keys} key.
+ [Go Back to the Cave Mouth] -> cave_mouth
-> END


== market ==
{You take a break from the exhausting cave exploration and walk to the market which is located in the nearby town. Once you arrive, you notice a variety vendors selling anything from food, animals, books, and medicine. It feels lively and welcoming.|You are at the market.}
What would you like to purchase?
+ [Food] { - market_food: 
			-> market_food_buy
		- else:
			-> market_food
	}
 + [Books] { - market_books: 
			-> market_books_buy
		- else:
			-> market_books
	}
 + [Animals]  { - market_pets: 
			-> market_pets_buy
		- else:
			-> market_pets
	}
+ [Go Back to the Cave Mouth] -> cave_mouth
-> END

== market_food ==
{You walk over to the vendor who appears to be selling food. The shelves are stocked with bread, cheese, and sweets.|}
+ [Take a closer.] -> market_food_buy
+ [Go Back to the market] -> market
-> END

== market_food_buy ==
{coins > 5: You have enough coins to buy a loaf of bread.|You do not have enough coins to buy anything.}
+ {coins > 5 } [Purchase a loaf of bread] -> food_buy
+ [Go Back to the market] -> market
-> END

=== food_buy ===
~ strength = strength + 1
~ coins = coins - 5
You consume the food. You now have {strength} strength. You only have {coins} coins now.
+ [Go Back to the market] -> market
+ [Go Back to the Cave Mouth] -> cave_mouth
-> END

== market_books ==
{You walk over to the vendor who appears to be selling books. There are stacks of large books on the table.|}
+ [Take a closer.] -> market_books_buy
+ [Go Back to the market] -> market
-> END

== market_books_buy ==
{You look at the books. The topics include medicine, fiction, and more.|} {coins > 5: You have enough coins to buy a book.| You do not have enough coins to buy anything.} 
+ {coins > 5 } [Purchase a book,] -> books_buy
+ [Go Back to the market] -> market
-> END

=== books_buy ===
~ intelligence = intelligence + 1
~ coins = coins - 5
You read the book. You now have {intelligence} intelligence. You only have {coins} coins now.
+ [Go Back to the market] -> market
+ [Go Back to the Cave Mouth] -> cave_mouth
-> END


== market_pets ==
{You walk over to the vendor who appears to be selling animals. There are rabbits, dogs, cats, and rats. |}
+ [Take a closer.] -> market_pets_buy
+ [Go Back to the market] -> market
-> END

== market_pets_buy ==
{You look at the animals. You miss your pet {pet_name} and wish you could buy a pet. You think about it a little more but know it would be unreasonable to have to care for a animal while exploring the cave.|} You decide its not the right time to buy a pet.

+ [Go Back to the market] -> market
+ [Go Back to the Cave Mouth] -> cave_mouth
-> END



== function advance_time ==

    ~ time = time + 1
    
    {
        - time > 4:
            ~ time = 0
    }    

    {    
        - time == 0:
            ~ return "Morning"
        
        - time == 1:
            ~ return "Noon"
        
        - time == 2:
            ~ return "Afternoon"
        
         - time == 3:
            ~ return "Dusk"
        
        - time == 4:
            ~ return "Night"
        
    
    }

        
    ~ return time
    

