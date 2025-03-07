append function genesis:load:
  scoreboard objectives add genesis.mob.hurt_tint dummy

function ~/activate:
  item_modifier ~/ {
    "function": "minecraft:set_components",
    "components": {
      "minecraft:dyed_color": 16733537
    }
  }
  execute if items entity @s armor.head *[minecraft:custom_data~{genesis:{mob:{hurt_tint:true}}}] run item modify entity @s armor.head ~/
  execute if items entity @s armor.chest *[minecraft:custom_data~{genesis:{mob:{hurt_tint:true}}}] run item modify entity @s armor.chest ~/
  execute if items entity @s armor.legs *[minecraft:custom_data~{genesis:{mob:{hurt_tint:true}}}] run item modify entity @s armor.legs ~/
  execute if items entity @s armor.feet *[minecraft:custom_data~{genesis:{mob:{hurt_tint:true}}}] run item modify entity @s armor.feet ~/
  execute if items entity @s weapon.mainhand *[minecraft:custom_data~{genesis:{mob:{hurt_tint:true}}}] run item modify entity @s weapon.mainhand ~/
  execute if items entity @s weapon.offhand *[minecraft:custom_data~{genesis:{mob:{hurt_tint:true}}}] run item modify entity @s weapon.offhand ~/
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
  execute if items entity @s armor.head *[minecraft:custom_data~{genesis:{mob:{hurt_tint:true}}}] run item modify entity @s armor.head ~/
  execute if items entity @s armor.chest *[minecraft:custom_data~{genesis:{mob:{hurt_tint:true}}}] run item modify entity @s armor.chest ~/
  execute if items entity @s armor.legs *[minecraft:custom_data~{genesis:{mob:{hurt_tint:true}}}] run item modify entity @s armor.legs ~/
  execute if items entity @s armor.feet *[minecraft:custom_data~{genesis:{mob:{hurt_tint:true}}}] run item modify entity @s armor.feet ~/
  execute if items entity @s weapon.mainhand *[minecraft:custom_data~{genesis:{mob:{hurt_tint:true}}}] run item modify entity @s weapon.mainhand ~/
  execute if items entity @s weapon.offhand *[minecraft:custom_data~{genesis:{mob:{hurt_tint:true}}}] run item modify entity @s weapon.offhand ~/
  scoreboard players reset @s genesis.mob.hurt_tint

function ~/schedule:
  scoreboard players set #temp genesis 0
  execute as @e[tag=genesis.mob.component.hurt_tint,scores={genesis.mob.hurt_tint=1..}] at @s run function ~/../tick
  execute if score #temp genesis matches 1 run schedule function ~/ 1t replace