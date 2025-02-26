function ~/activate:
  item_modifier ~/ {
    "function": "minecraft:set_components",
    "components": {
      "minecraft:dyed_color": 16733537
    }
  }
  item modify entity @s armor.head ~/
  item modify entity @s armor.legs ~/
  item modify entity @s weapon.mainhand ~/
  item modify entity @s weapon.offhand ~/
  scoreboard players operation @s genesis.mob.hurt_tint = #hurt_time genesis
  schedule function ~/../schedule 1t replace

function ~/tick:
  scoreboard players remove @s genesis.mob.hurt_tint 1
  execute if score @s genesis.mob.hurt_tint matches ..0 run return run function ~/../deactivate
  scoreboard players set #temp genesis 1

function ~/deactivate:
  item_modifier ~/ {
    "function": "minecraft:set_components",
    "components": {
      "!minecraft:dyed_color": {}
    }
  }
  item modify entity @s armor.head ~/
  item modify entity @s armor.legs ~/
  item modify entity @s weapon.mainhand ~/
  item modify entity @s weapon.offhand ~/
  scoreboard players reset @s genesis.mob.hurt_tint

function ~/schedule:
  scoreboard players set #temp genesis 0
  execute as @e[tag=genesis.mob.component.hurt_tint,scores={genesis.mob.hurt_tint=1..}] at @s run function ~/../tick
  execute if score #temp genesis matches 1 run schedule function ~/ 1t replace