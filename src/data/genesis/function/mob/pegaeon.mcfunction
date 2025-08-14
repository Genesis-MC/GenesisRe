from genesis:interaction import call_on_rclick_tagged, call_on_lclick_tagged
from genesis:item import GenesisItem, block_model_item
from genesis:schedule import schedule_on_entity_fixed
from genesis:worldgen import create_command_jigsaw_feature
MAX_DIST_BETWEEN_NESTS = 2500
FLYING_HEIGHT_ABOVE_GROUND = 20
FLYING_SPEED = 40
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
  create_command_jigsaw_feature("pegaeon_nest", f"function {~/}")
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
  SEAT_HEIGHT = 1.0625
  summon item_display ~ ~ ~ {Tags:["genesis","genesis.pegaeon","genesis.pegaeon.parked","genesis.pegaeon.new"],teleport_duration:3,transformation:{left_rotation:[0f,1f,0f,0f],right_rotation:[0f,0f,0f,1f],translation:[0f,1f,0f],scale:[1f,1f,1f]},Passengers:([{id:"minecraft:interaction",width:WIDTH,height:HEIGHT,response:true,Tags:["genesis","genesis.interaction","genesis.pegaeon"]},{id:"minecraft:interaction",width:0,height:SEAT_HEIGHT,Tags:["genesis","genesis.pegaeon.seat"]}])}
  execute as @n[type=item_display,tag=genesis.pegaeon.new,distance=..0.1]:
    tag @s remove genesis.pegaeon.new
    data modify storage genesis:temp mob.pegaeon.macro set value {}
    data modify storage genesis:temp mob.pegaeon.macro.x set from storage genesis:temp mob.pegaeon.mount.home.rotation[0]
    with storage genesis:temp mob.pegaeon.macro:
      $rotate @s $(x) 0
    data modify entity @s data set from storage genesis:temp mob.pegaeon.mount
    execute rotated as @s run function animated_java:genesis_pegaeon/summon {args:{animation:"idle",frame:0}}
    execute on passengers if entity @s[type=interaction,tag=genesis.pegaeon.seat] run ride @n[type=minecraft:item_display,tag=aj.genesis_pegaeon.root,distance=..0.1] mount @s
    execute on passengers if entity @s[type=interaction,tag=genesis.pegaeon.seat] on passengers if entity @s[type=item_display,tag=aj.genesis_pegaeon.root] on passengers if entity @s[type=item_display,tag=aj.genesis_pegaeon.bone] run data modify entity @s item.components."minecraft:dyed_color" set from storage genesis:temp mob.pegaeon.mount.color

function ~/lclick:
  call_on_lclick_tagged("genesis.pegaeon")
  execute on attacker unless entity @s[gamemode=creative] run return fail
  execute on vehicle run function genesis:utils/entity/kill_stack

function ~/rclick:
  call_on_rclick_tagged("genesis.pegaeon")
  execute on vehicle if entity @s[tag=genesis.pegaeon.flying] run return fail
  execute on vehicle:
    tag @s remove genesis.pegaeon.parked
    tag @s add genesis.pegaeon.taking_off
    data modify storage genesis:temp mob.pegaeon.mount set from entity @s data
    execute summon marker:
      tag @s add genesis
      tag @s add genesis.pegaeon_absent
      data modify entity @s data set from storage genesis:temp mob.pegaeon.mount
      schedule_on_entity_fixed("function genesis:mob/pegaeon/reappear", 50)
    execute on passengers if entity @s[type=interaction,tag=genesis.pegaeon.seat] on passengers if entity @s[type=item_display,tag=aj.genesis_pegaeon.root] run function animated_java:genesis_pegaeon/animations/take_off/play
    schedule_on_entity_fixed("function genesis:mob/pegaeon/finish_takeoff", 40)
    execute on passengers if entity @s[type=interaction,tag=genesis.pegaeon.seat] run ride @p[tag=genesis.interaction.player] mount @s
  kill @s

function ~/finish_takeoff:
  tag @s remove genesis.pegaeon.taking_off
  tag @s add genesis.pegaeon.flying
  execute on passengers if entity @s[type=interaction,tag=genesis.pegaeon.seat] on passengers if entity @s[type=item_display,tag=aj.genesis_pegaeon.root] run function animated_java:genesis_pegaeon/animations/flying/play
  schedule function ~/../flying_tick 1t replace


function ~/reappear:
  data modify storage genesis:temp mob.pegaeon.mount set from entity @s data
  kill @s
  function ~/../spawn

function ~/flying_tick:
  execute if entity @e[type=item_display,tag=genesis.pegaeon.flying,limit=1] run schedule function ~/ 1t replace
  execute as @e[type=item_display,tag=genesis.pegaeon.flying] at @s:
    scoreboard players set #has_passenger genesis 0
    execute on passengers if entity @s[type=interaction,tag=genesis.pegaeon.seat] on passengers unless entity @s[type=item_display] run scoreboard players set #has_passenger genesis 1
    execute if score #has_passenger genesis matches 0 run return run function ~/../lose_passenger
    data modify storage genesis:temp mob.pegaeon.mount set from entity @s data
    data modify storage genesis:temp mob.pegaeon.pos set from entity @s Pos
    execute store result score #distance_to_home genesis run data get storage genesis:temp mob.pegaeon.mount.home.pos[0] 1
    execute store result score #temp genesis run data get storage genesis:temp mob.pegaeon.pos[0] 1
    scoreboard players operation #distance_to_home genesis -= #temp genesis
    scoreboard players operation #distance_to_home genesis *= #distance_to_home genesis
    execute store result score #temp genesis run data get storage genesis:temp mob.pegaeon.mount.home.pos[2] 1
    execute store result score #temp2 genesis run data get storage genesis:temp mob.pegaeon.pos[2] 1
    scoreboard players operation #temp genesis -= #temp2 genesis
    scoreboard players operation #temp genesis *= #temp genesis
    scoreboard players operation #distance_to_home genesis += #temp genesis
    execute store result score #distance_to_target genesis run data get storage genesis:temp mob.pegaeon.mount.target_pos[0] 1
    execute store result score #temp genesis run data get storage genesis:temp mob.pegaeon.pos[0] 1
    scoreboard players operation #distance_to_target genesis -= #temp genesis
    scoreboard players operation #distance_to_target genesis *= #distance_to_target genesis
    execute store result score #temp genesis run data get storage genesis:temp mob.pegaeon.mount.target_pos[2] 1
    execute store result score #temp2 genesis run data get storage genesis:temp mob.pegaeon.pos[2] 1
    scoreboard players operation #temp genesis -= #temp2 genesis
    scoreboard players operation #temp genesis *= #temp genesis
    scoreboard players operation #distance_to_target genesis += #temp genesis
    execute if score #distance_to_target genesis matches (None, 4**2) run return run function ~/../reach_target
    
    execute:
      execute if score #distance_to_target genesis matches (None, 50**2) run return:
        execute store result score #target_y genesis run data get storage genesis:temp mob.pegaeon.mount.target_pos[1] 1
        execute if score #distance_to_target genesis matches (15**2, None) scoreboard players add #target_y genesis 8
      execute if score #distance_to_home genesis matches (None, 20**2) run return:
        execute store result score #target_y genesis run data get storage genesis:temp mob.pegaeon.mount.home.pos[1] 1
        scoreboard players add #target_y genesis 8
      execute rotated ~ 0 positioned ^ ^ ^ positioned over world_surface summon marker:
        execute store result score #target_y genesis run data get entity @s Pos[1] 1
        for k in range(5):
          f = (k+1) * 6
          execute positioned ^ ^ ^k:
            for i in range(-1, 2):
              for j in range(-1, 2):
                if not (i == 0 and j == 0):
                  x = 3 * i
                  z = 3 * j
                  execute positioned ~x ~ ~z positioned over world_surface run tp @s ~ ~ ~
                  #execute at @s run particle note ~ ~ ~ 0 0 0 0 1 force @a
                  execute store result score #temp genesis run data get entity @s Pos[1] 1
                  scoreboard players operation #target_y genesis > #temp genesis
        kill @s
      scoreboard players add #target_y genesis FLYING_HEIGHT_ABOVE_GROUND
    
    execute store result score #temp genesis run data get storage genesis:temp mob.pegaeon.pos[1] 1
    scoreboard players operation #target_y genesis -= #temp genesis
    data modify storage genesis:temp mob.pegaeon.macro set value {}
    execute store result storage genesis:temp mob.pegaeon.macro.dy int 1 scoreboard players get #target_y genesis
    with storage genesis:temp mob.pegaeon.macro:
      $execute rotated ~ 0 run rotate @s facing ^ ^$(dy) ^10
    execute rotated as @s on passengers if entity @s[type=interaction,tag=genesis.pegaeon.seat] on passengers if entity @s[type=item_display,tag=aj.genesis_pegaeon.root] run rotate @s ~ ~

    #tellraw @a ["",{"text":"to_home="},{"score":{"name":"#distance_to_home","objective":"genesis"}},{"text":", to_target="},{"score":{"name":"#distance_to_target","objective":"genesis"}},{"text":", target_y="},{"score":{"name":"#target_y","objective":"genesis"}}]
    speed_per_tick = FLYING_SPEED / 20
    execute rotated as @s run tp @s ^ ^ ^speed_per_tick
      

function ~/lose_passenger:
  function ~/../kill

function ~/reach_target:
  function ~/../kill

function ~/kill:
  execute on passengers if entity @s[type=interaction,tag=genesis.pegaeon.seat] on passengers if entity @s[type=item_display,tag=aj.genesis_pegaeon.root] run function animated_java:genesis_pegaeon/remove/this
  execute on passengers if entity @s[type=interaction,tag=genesis.pegaeon.seat] on passengers run effect give @s minecraft:slow_falling 3
  execute on passengers if entity @s[type=interaction,tag=genesis.pegaeon.seat] on passengers run ride @s dismount
  function genesis:utils/entity/kill_stack

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

      execute if score #can_hatch genesis matches 1 as @e[type=item_display,tag=genesis.pegaeon,distance=..10] run function ~/check_for_connection:
        # check if connection already exists
        data modify storage genesis:temp temp set from storage genesis:temp mob.pegaeon.egg.components."minecraft:lodestone_tracker".target.pos
        execute store success score #temp genesis run data modify storage genesis:temp temp set from entity @s data.target_pos
        execute if score #temp genesis matches 0 run scoreboard players set #can_hatch genesis 0
      execute if score #can_hatch genesis matches 1 as @e[type=marker,tag=genesis.pegaeon_absent,distance=..10] run function ~/check_for_connection
      
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
      execute if score #can_hatch genesis matches 1 on target unless entity @s[gamemode=creative] run item modify entity @s weapon.mainhand {function:"minecraft:set_count",count:-1,add:true}
      
      #tellraw @a {"text":"can_hatch=","extra":[{"score":{"name":"#can_hatch","objective":"genesis"}}]}

  
  function ~/lclick:
    call_on_lclick_tagged("genesis.pegaeon_nest")
    execute on attacker unless entity @s[gamemode=creative] run return fail
    execute on vehicle run function genesis:utils/entity/kill_stack