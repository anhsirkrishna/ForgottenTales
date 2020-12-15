# ForgottenTales
Forgotten Tales is a 2D Strategy CRPG. Developed from scratch using LOVE2D, a 2D game engine. 

Download Link : https://drive.google.com/file/d/1T3o2mEvOwWkW2xEaXEsuI5vwFJnh2oFb/view?usp=sharing
Exactract and run the exe to play !

Forgotten Tales is a small RPG game featuring :

 - A turn based combat system
 - A stat/attribute system 
 - A spell system
 - An inventory system
 - A dialogue system

The goal of the game is to traverse through the level, defeat all the enemies, collect loot to empower your character and finally face off and kill the final Boss. 

Control of the game is done using :
 - The WASD keys or the Arrow keys to control the camera
 - Pointing and clicking with the mouse for everything else

To start off, clicking the main character will provide a small menu with three buttons :
 - Move : Allows the character to move a number of spaces equal to his movespeed
 - Action : Brings up another menu which lists three further options 
     - Attack : Allows the character to attack an enemy during combat
     - Spell : Allows a character to cast a spell from the spell menu
     - Check : Allows the character to check a dead enemy body for loot
 - Stat : Brings up the stat and inventory menu for the character. You can see the character's stats and inventory here. 

Select the Move option to move the character throughout the level. 
If the player character comes within range of an enemy's sight then combat will begin. 

Combat is divided into player turn and enemy turn. 
During player turn the player character can :
 - Move once
 - Attack once
 - Cast as many spells as you'd like as long as you have sufficient spell points.
 - Open up the Stat menu to view stats such as Atk, Def, Hp etc. 
 - Select items from the inventory to use them. Such as potions to refill your health/spell points.
 - Check enemy corpses for loot.
Once the player has performed all their actions, they can hit the "End" button to end their turn and trigger the enemy turn. 

During the enemy turn the enemies will approach the player character and attempt to attack and kill the player character.
If the player character's HP reaches 0 then it is "Game Over" and the player will have to try again from the start. 

Once the player character has killed all the visible enemies then combat ends and there are no more turns. 
The player can kill enemies by reducing their HP to 0. 
This can be accomplished in two ways : 
 - Using the "Attack" action : This triggers an attack animation where the player character has to roll a dice to see if they hit or miss the enemy. If the number rolled on the dice + the attacker's ATK stat - the defender's DEF stat is greater than 10, then the attack will successfully land and deal damage according to the equipped weapon. If the number is less than 10, then the attack will miss and do no damage. If the number rolled on the dice is 20 then it is a critical hit and the attack will deal double damage. 
 - Using the "Spell" action : The player character can continue to use spells as long as he has sufficient spell points. Each spell has an associated cost which will deplete the player's spell points. Once again a dice is rolled to determine if the spell hits or misses. If the number rolled on the dice + the attacker's SPL stat - the defender's RES stat is greater than 10, then the spell will successfully land and deal damage according to the spell damage and apply the associated spell effect on the target. 

If the player loots a weapon or armour from the enemy corpse, they can then equip the newly obtained item by clicking on it from the inventory menu to make themeselves stronger. 

# Traverse through the level, find better loot and slay the final boss to win the game !


