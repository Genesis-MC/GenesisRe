function ~/hurt:
  pass

function ~/death:
  pass

function ~/ambient:
  pass

append function ../../tick:
  execute at @a as @e[tag=genesis.mob.component.custom_sounds,distance=..16,predicate=~/../mob/component/custom_sounds/ambient,limit=1] at @s run function ~/../mob/component/custom_sounds/ambient

predicate ~/ambient {
  "condition": "minecraft:random_chance",
  "chance": 0.005
}