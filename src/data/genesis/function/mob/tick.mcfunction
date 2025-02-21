predicate ./hurt_detection {
  "condition": "inverted",
  "term": {
    "condition": "entity_properties",
    "entity": "this",
    "predicate": {
      "effects": {
        "absorption": {}
      }
    }
  }
}

execute as @e[tag=genesis.mob.component.hurt_detection,predicate=./hurt_detection] at @s run function ./hurt_detection:
  effect give @s minecraft:absorption infinite 0 true
  execute store result score #hurt_time genesis run data get entity @s HurtTime
  execute unless score #hurt_time genesis matches 1.. run return fail

  execute if entity @s[tag=genesis.mob.component.hurt_tint] run function ./hurt_tint/activate