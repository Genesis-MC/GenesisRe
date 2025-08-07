from genesis:interaction import call_on_rclick_tagged, call_on_lclick_tagged
from genesis:item import GenesisItem, block_model_item
MAX_DIST_BETWEEN_NESTS = 1000
ROOT = ~/

class PegaeonEgg(GenesisItem):
    item_name = ("Pegaeon Egg", {})
    rarity = "uncommon"
    category = ["curio"]
    lodestone_tracker = {
      "target": {
        "dimension": "minecraft:overworld"
      },
      "tracked": False
    }
    enchantment_glint_override = False
    item_model = "genesis:curio/pegaeon_egg"

NestModelItem = block_model_item("pegaeon_nest")

### API FUNCS ###
function ~/spawn_nest:
  """
  Spawns a nest with 3 eggs
  """
  WIDTH = 2
  HEIGHT = 0.5
  execute align xyz positioned ~0.5 ~ ~0.5 if entity @e[type=item_display,tag=genesis.pegaeon_nest,distance=..0.1] run return fail
  eggs = []
  for i in range(3):
    eggs.append({"id":"minecraft:item_display","Tags":["genesis","genesis.pegaeon_egg_in_nest"],"Rotation":[(120*i),0],"width":WIDTH,"height":HEIGHT,"transformation":{"left_rotation":[0,0,0,1],"right_rotation":[0,0,0,1],"translation":[0.7,0.54,0],"scale":[1,1,1]}})
  execute align xyz positioned ~0.5 ~ ~0.5 run summon item_display ~ ~ ~ {Tags:["genesis","genesis.pegaeon_nest"],item:NestModelItem,width:WIDTH,height:HEIGHT,transformation:{left_rotation:[0f,1f,0f,0f],right_rotation:[0f,0f,0f,1f],translation:[0f,0.52f,0f],scale:[1f,1f,1f]},Passengers:([{id:"minecraft:interaction",width:WIDTH,height:HEIGHT,response:true,Tags:["genesis","genesis.interaction","genesis.pegaeon_nest"]}] + eggs)}
  execute align xyz positioned ~0.5 ~ ~0.5 as @n[type=item_display,tag=genesis.pegaeon_nest,distance=..0.1]:
    # initialise nest
    data modify storage genesis:temp mob.pegaeon set value {nest:{pos:[I;0,0,0]},egg:{id:PegaeonEgg.base_item,components:PegaeonEgg.components}}
    data modify storage genesis:temp mob.pegaeon.egg.components."minecraft:custom_model_data".colors set value [0]
    execute store result storage genesis:temp mob.pegaeon.egg.components."minecraft:custom_model_data".colors[0] int 1 run random value 0..16777215
    for i in range(3):
      execute store result storage genesis:temp mob.pegaeon.nest.pos[i] int 1 run data get entity @s Pos[i] 1
    data modify entity @s data set from storage genesis:temp mob.pegaeon.nest
    data modify storage genesis:temp mob.pegaeon.egg.components."minecraft:lodestone_tracker".target.pos set from storage genesis:temp mob.pegaeon.nest.pos
    execute on passengers if entity @s[type=item_display,tag=genesis.pegaeon_egg_in_nest] run data modify entity @s item set from storage genesis:temp mob.pegaeon.egg


### INTERNAL FUNCS ###
SAFE_BLOCK_CONFIG = ~/safe_block_configuration
block_checks = [
  {
    "condition": "minecraft:inverted",
    "term": {
      "condition": "minecraft:location_check",
      "offsetY": -1,
      "predicate": {
        "block": {
          "blocks": "#minecraft:air"
        }
      }
    }
  }
]
for x in range(-1, 2):
  for y in range(2):
    for z in range(-1, 2):
      block_checks.append({
        "condition": "minecraft:location_check",
        "offsetX": x,
        "offsetY": y,
        "offsetZ": z,
        "predicate": {
          "block": {
            "blocks": "#minecraft:air"
          }
        }
      })
predicate SAFE_BLOCK_CONFIG {
  "condition": "minecraft:all_of",
  "terms": block_checks
}

function ~/spawn:
  WIDTH = 2
  HEIGHT = 2
  summon item_display ~ ~ ~ {Tags:["genesis","genesis.pegaeon","genesis.pegaeon.parked","genesis.pegaeon.new"],item:{id:"minecraft:dragon_head"},width:WIDTH,height:HEIGHT,transformation:{left_rotation:[0f,1f,0f,0f],right_rotation:[0f,0f,0f,1f],translation:[0f,1f,0f],scale:[1f,1f,1f]},Passengers:([{id:"minecraft:interaction",width:WIDTH,height:HEIGHT,response:true,Tags:["genesis","genesis.interaction","genesis.pegaeon"]}])}
  execute as @n[type=item_display,tag=genesis.pegaeon.new,distance=..0.1]:
    tag @s remove genesis.pegaeon.new
    data modify storage genesis:temp mob.pegaeon.macro set value {}
    data modify storage genesis:temp mob.pegaeon.macro.x set from storage genesis:temp mob.pegaeon.mount.home.rotation[0]
    with storage genesis:temp mob.pegaeon.macro:
      $rotate @s $(x) 0
    data modify entity @s data set from storage genesis:temp mob.pegaeon.mount

function ~/lclick:
  call_on_lclick_tagged("genesis.pegaeon")
  execute on vehicle run function genesis:utils/entity/kill_stack

function ~/nest:
  function ~/rclick:
    call_on_rclick_tagged("genesis.pegaeon_nest")
    execute store success score #temp genesis on target unless items entity @s weapon.mainhand * 
    execute if score #temp genesis matches 1 on vehicle on passengers if entity @s[type=item_display,tag=genesis.pegaeon_egg_in_nest] run scoreboard players set #temp genesis 2
    execute if score #temp genesis matches 2 as @e[type=item_display,tag=genesis.pegaeon_egg_in_nest,distance=..0.1,limit=1,sort=random] run return:
      item replace entity @p[tag=genesis.interaction.player] weapon.mainhand from entity @s contents
      kill @s
    
    execute store success score #temp genesis on target if items entity @s weapon.mainhand PegaeonEgg.selector
    execute if score #temp genesis matches 1 unless entity @e[type=item_display,tag=genesis.pegaeon_egg_hatching,distance=..5]:
      # spawn hatching egg
      particle minecraft:poof ~ ~ ~ 0 0 0 0 3
      execute on target run data modify storage genesis:temp mob.pegaeon.egg set from entity @s SelectedItem
      data modify storage genesis:temp mob.pegaeon.macro set value {}
      for i, axis in enumerate("xyz"):
        data modify storage genesis:temp f"mob.pegaeon.macro.{axis}" set from storage genesis:temp mob.pegaeon.egg.components."minecraft:lodestone_tracker".target.pos[i]
      scoreboard players set #can_hatch genesis 0
      scoreboard players set #squared_distance genesis 0
      for i in range(3):
        execute store result score #temp genesis run data get entity @s Pos[i] 1
        execute store result score #temp2 genesis run data get storage genesis:temp mob.pegaeon.egg.components."minecraft:lodestone_tracker".target.pos[i] 1
        scoreboard players operation #temp genesis -= #temp2 genesis
        scoreboard players operation #temp genesis *= #temp genesis
        scoreboard players operation #squared_distance genesis += #temp genesis
      execute if score #squared_distance genesis matches (100, MAX_DIST_BETWEEN_NESTS**2) run scoreboard players set #can_hatch genesis 1
      
      execute summon item_display:
        with storage genesis:temp mob.pegaeon.macro:
          $rotate @s facing $(x) ~ $(z)
        execute if score #can_hatch genesis matches 1 rotated as @s:
          scoreboard players set #can_hatch genesis 0
          execute positioned ^ ^ ^4 align xyz positioned ~0.5 ~ ~0.5 run function ~/find_safe_spot:
            # search for safe spot to spawn pegaeon
            for x, z in [(0,0),(1,0),(0,1),(-1,0),(0,-1),(1,1),(1,-1),(-1,1),(-1,-1)]:
              for y in [2,1,0,-1,-2]:
                execute positioned ~x ~y ~z if predicate SAFE_BLOCK_CONFIG positioned ~-1 ~-1 ~-1 unless entity @e[type=interaction,tag=genesis.pegaeon,dx=1,dy=1,dz=1] positioned ~1 ~1 ~1 summon marker run return run function ~/../found_safe_spot
          execute if score #can_hatch genesis matches 0 rotated ~-20 ~ positioned ^ ^ ^4 align xyz positioned ~0.5 ~ ~0.5 run function ~/find_safe_spot
          execute if score #can_hatch genesis matches 0 rotated ~20 ~ positioned ^ ^ ^4 align xyz positioned ~0.5 ~ ~0.5 run function ~/find_safe_spot
        function ~/found_safe_spot:
          scoreboard players set #can_hatch genesis 1
          with storage genesis:temp mob.pegaeon.macro:
            $rotate @s facing $(x) ~ $(z)
          data modify storage genesis:temp mob.pegaeon.mount set value {home:{pos:[0,0,0]}}
          data modify storage genesis:temp mob.pegaeon.mount.target_pos set from storage genesis:temp mob.pegaeon.egg.components."minecraft:lodestone_tracker".target.pos
          data modify storage genesis:temp mob.pegaeon.mount.color set from storage genesis:temp mob.pegaeon.egg.components."minecraft:custom_model_data".colors[0]
          for i in range(3):
            execute store result storage genesis:temp mob.pegaeon.mount.home.pos[i] int 1 run data get entity @s Pos[i] 1
            data modify storage genesis:temp mob.pegaeon.mount.home.rotation set from entity @s Rotation
          kill @s
          function f"{ROOT}/spawn"
        kill @s
      
      tellraw @a {"text":"can_hatch=","extra":[{"score":{"name":"#can_hatch","objective":"genesis"}}]}

  
  function ~/lclick:
    call_on_lclick_tagged("genesis.pegaeon_nest")
    execute on vehicle run function genesis:utils/entity/kill_stack