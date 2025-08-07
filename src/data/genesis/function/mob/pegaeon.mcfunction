from genesis:interaction import call_on_rclick_tagged, call_on_lclick_tagged
from genesis:item import GenesisItem, block_model_item

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
  execute align xyz positioned ~0.5 ~ ~0.5 run summon item_display ~ ~ ~ {Tags:["genesis","genesis.pegaeon_nest"],item:NestModelItem,width:WIDTH,height:HEIGHT,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0.52f,0f],scale:[1f,1f,1f]},Passengers:([{id:"minecraft:interaction",width:WIDTH,height:HEIGHT,response:true,Tags:["genesis","genesis.interaction","genesis.pegaeon_nest"]}] + eggs)}
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
function ~/nest:
  function ~/rclick:
    call_on_rclick_tagged("genesis.pegaeon_nest")
    execute store success score #temp genesis on target unless items entity @s weapon.mainhand * 
    execute if score #temp genesis matches 1 on vehicle on passengers if entity @s[type=item_display,tag=genesis.pegaeon_egg_in_nest] run scoreboard players set #temp genesis 2
    execute if score #temp genesis matches 2 as @e[type=item_display,tag=genesis.pegaeon_egg_in_nest,distance=..0.1,limit=1,sort=random]:
      item replace entity @p[tag=genesis.interaction.player] weapon.mainhand from entity @s contents
      kill @s
  
  function ~/lclick:
    call_on_lclick_tagged("genesis.pegaeon_nest")
    execute on vehicle run function genesis:utils/entity/kill_stack