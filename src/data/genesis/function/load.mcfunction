from genesis:genesis_items import EtherealChestplate

append function_tag minecraft:load { "values": [ "genesis:load" ] }

say loaded
function ./crafter/tick

# ❂❂❂❂❂❂
def table(item):
    loot_table f'{item.namespace}:bolt-item/{item.id}' {"pools": [{"rolls": 1,"entries": [{"type": "minecraft:item","name": "minecraft:poisonous_potato","functions": [{"function": "minecraft:set_components","components": item.components}]}]}]}

table(EtherealChestplate)
