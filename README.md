# Project-01

# Your Name
Angela Tan
# Your Github username
angelat8
# List the things you added for points

- Create at least one major choice that the player can make
  - The player is faced with a boulder blocking their path, they must find potions to upgrade their strength and choose how they will overcome the obstacle carefully.  
- Reflect that choice back to the player
  - If the player has enough strength and chooses to push the boulder, they will succeed. If the player tries to dig around, they will fail. If the player tries to squeeze past the boulder, they die.
- Include at least one loop
  - I use a loop to advance time–each time the player returns to the cave mouth or visits other select passages, such as the moving boulder knot, time will advance.
  - Additionally, simple loops are used in a few passages that are often re-visited to vary the content (Ex: east_tunnel and west_tunnel knot)
  
- Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
  - The Player is able to pick up a key, potions, and a torch. If they have the key in their inventory, the player is able to open a chest. If they pick up the torch, the player can unlock new paths and find other items. When picking up a potion, the player’s stats are upgraded.
  - If the player does not have a torch, they will be unable to go further down the east tunnel, and it will acknowledge that the player has not picked the torch up yet. Additionally, when the player does not have a key and tries to pry the chest open, the player will fail at the task and will be prompted to find the key first.
- Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
  - The player can find potions in the cave to upgrade their strength and intelligence stat. Later, when encountering a boulder, the player must have at least 10 strength points to choose the option to push the boulder out of the way. Additionally, if the player has at least 3 intelligence points, they are able to use lockpicking on a chest instead of a key.
- Keep track of visited passages and only display the description when visiting for the first time (or requested)
  - After visiting areas with items and picking them up, the description will change based on the player’s actions and exclude details relating to the item. 
  - In re-visitable passages that are long or describe the appearance of areas, it will only be displayed when visiting the first time. After, when visiting again, there is only a short sentence about where the player is located or prompting the player to select a choice (ex: in the market-related knots, and the east_tunnel_lit and cave_mouth knots, etc).
- Include more than 16 passages
