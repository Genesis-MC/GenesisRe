function ~/triggered:
  effect give @s minecraft:absorption infinite 0 true
  execute store result score #hurt_time genesis run data get entity @s HurtTime
  execute unless score #hurt_time genesis matches 1.. run return fail

  execute store result score #death_time genesis run data get entity @s DeathTime

  execute if entity @s[tag=genesis.mob.component.custom_sounds] run function ~/../call_custom_sounds

  execute if entity @s[tag=genesis.mob.component.hurt_tint] run function ./hurt_tint/activate

function ~/call_custom_sounds:
  execute if score #death_time genesis matches 1.. run function ./custom_sounds/death
  execute unless score #death_time genesis matches 1.. run function ./custom_sounds/hurt