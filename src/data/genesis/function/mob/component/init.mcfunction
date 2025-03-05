item_modifier ~/remove_enchantment {
  "function": "minecraft:set_enchantments",
  "enchantments": {
    "genesis:mob/component/init_tick": 0
  },
  "add": false
}

function ~/tick:
  item modify entity @s armor.head ~/../remove_enchantment

function ~/set_home_memory:
  data modify storage genesis:mob temp.pos set from entity @s Pos
  data modify storage genesis:mob temp.memory set value {value:{pos:[I;0,0,0],dimension:"minecraft:overworld"}}
  execute if dimension minecraft:the_end run data modify storage genesis:mob temp.memory.value.dimension set value "minecraft:the_end"
  execute if dimension minecraft:the_nether run data modify storage genesis:mob temp.memory.value.dimension set value "minecraft:the_nether"
  execute store result storage genesis:mob temp.memory.value.pos[0] int 1 run data get storage genesis:mob temp.pos[0] 1
  execute store result storage genesis:mob temp.memory.value.pos[1] int 1 run data get storage genesis:mob temp.pos[1] 1
  execute store result storage genesis:mob temp.memory.value.pos[2] int 1 run data get storage genesis:mob temp.pos[2] 1
  data modify entity @s Brain.memories."minecraft:home" set from storage genesis:mob temp.memory