from ps_beet_bolt.bolt_item import bolt_item
from genesis:item/global import GenesisItem
from genesis:placeable import on_place
from genesis:utils import add_loot_table


input_slots = [2,3,4,11,12,13,20,21,22]
output_slot = 15
player_slots = ["player.cursor","weapon.offhand","hotbar.0","hotbar.1","hotbar.2","hotbar.3","hotbar.4","hotbar.5","hotbar.6","hotbar.7","hotbar.8","inventory.0","inventory.1","inventory.2","inventory.3","inventory.4","inventory.5","inventory.6","inventory.7","inventory.8","inventory.9","inventory.10","inventory.11","inventory.12","inventory.13","inventory.14","inventory.15","inventory.16","inventory.17","inventory.18","inventory.19","inventory.20","inventory.21","inventory.22","inventory.23","inventory.24","inventory.25","inventory.26"]


append function genesis:load:
    scoreboard objectives add genesis.crafter.item_count dummy
    function ./crafter/tick


append function genesis:tick:
    as @e[type=item_display,tag=genesis.crafter] at @s function genesis:crafter/tick


function ~/tick:
    unless block ~ ~-1 ~ barrel positioned ~ ~-.5 ~ return run function ~/../break_crafter:
        kill @e[type=minecraft:item,distance=..3,nbt={Age:0s,Item:{components:{"minecraft:custom_data":{genesis:{crafter:{placeholder:1b}}}}}}]
        loot replace entity @n[type=minecraft:item,distance=..3,nbt={Age:0s,Item:{id:"minecraft:barrel"}}] contents loot genesis:item/crafting_station/crafter
        kill @s
    if block ~ ~-2 ~ hopper[enabled=true] function ~/../disable_hopper:
        if block ~ ~-2 ~ hopper[facing=down] setblock ~ ~-2 ~ hopper[facing=down,enabled=false] replace
        if block ~ ~-2 ~ hopper[facing=east] setblock ~ ~-2 ~ hopper[facing=east,enabled=false] replace
        if block ~ ~-2 ~ hopper[facing=west] setblock ~ ~-2 ~ hopper[facing=west,enabled=false] replace
        if block ~ ~-2 ~ hopper[facing=north] setblock ~ ~-2 ~ hopper[facing=north,enabled=false] replace
        if block ~ ~-2 ~ hopper[facing=south] setblock ~ ~-2 ~ hopper[facing=south,enabled=false] replace
    store result score .placeholders genesis.crafter.item_count if items block ~ ~-1 ~ container.* white_stained_glass_pane[custom_data~{genesis:{crafter:{placeholder:1b}}}]
    unless score .placeholders genesis.crafter.item_count matches 18 function ~/../fix_placeholders:
        data remove storage genesis:temp crafter.regive.item
        for i in range(27):
            if i in input_slots:
                continue
            if i == output_slot:
                unless items block ~ ~-1 ~ f'container.{i}' *[custom_data~{genesis:{crafter:{placeholder:1b}}}] if items block ~ ~-1 ~ f'container.{i}' * data modify storage genesis:temp crafter.regive.item set from block ~ ~-1 ~ f'Items[{{Slot:{i}b}}]'
                if entity @s[tag=genesis.crafter.has_output] unless items block ~ ~-1 ~ f'container.{i}' *[custom_data~{genesis:{crafter:{placeholder:1b}}}] function ~/../result_has_been_removed
                raw f'execute unless items block ~ ~-1 ~ container.{i} *[custom_data~{{genesis:{{crafter:{{placeholder:1b}}}}}}] run item replace block ~ ~-1 ~ container.{i} with white_stained_glass_pane[item_model=red_stained_glass_pane,tooltip_display={{hide_tooltip:true}},custom_data={{genesis:{{crafter:{{placeholder:1b}}}}}}]'
            else:
                unless items block ~ ~-1 ~ f'container.{i}' white_stained_glass_pane[custom_data~{genesis:{crafter:{placeholder:1b}}}] if items block ~ ~-1 ~ f'container.{i}' * data modify storage genesis:temp crafter.regive.item set from block ~ ~-1 ~ f'Items[{{Slot:{i}b}}]'
                raw f'item replace block ~ ~-1 ~ container.{i} with white_stained_glass_pane[tooltip_display={{hide_tooltip:true}},custom_data={{genesis:{{crafter:{{placeholder:1b}}}}}}]'
        clear @a white_stained_glass_pane[custom_data~{genesis:{crafter:{placeholder:1b}}}]
        as @e[type=minecraft:item,distance=..3] if items entity @s contents white_stained_glass_pane[custom_data~{genesis:{crafter:{placeholder:1b}}}] kill @s
        if data storage genesis:temp crafter.regive.item function ~/../regive_item with storage genesis:temp crafter.regive:
            $summon item ~ ~.1 ~ {Item:$(item),Motion:[0.0d,0.2d,0.0d]}
    store result score .new genesis.crafter.item_count if items block ~ ~-1 ~ container.* *
    if score .new genesis.crafter.item_count = @s genesis.crafter.item_count return 0
    scoreboard players operation @s genesis.crafter.item_count = .new genesis.crafter.item_count
    tag @s remove genesis.crafter.has_output

    unless function ~/../recipes:
        raw ("return run item replace block ~ ~-1 ~ container.15 with white_stained_glass_pane[item_model=red_stained_glass_pane,tooltip_display={hide_tooltip:true},custom_data={genesis:{crafter:{placeholder:1b}}}]")

    data modify block ~ ~-1 ~ Items[{Slot:15b}].components.minecraft:custom_data.genesis.crafter.placeholder set value 1b
    tag @s add genesis.crafter.has_output


function ~/fill_page:
    for i in range(27):
        if i in input_slots:
            continue
        if i == output_slot:
            raw f'item replace block ~ ~-1 ~ container.{i} with white_stained_glass_pane[item_model=red_stained_glass_pane,tooltip_display={{hide_tooltip:true}},custom_data={{genesis:{{crafter:{{placeholder:1b}}}}}}]'
            continue
        raw f'item replace block ~ ~-1 ~ container.{i} with white_stained_glass_pane[tooltip_display={{hide_tooltip:true}},custom_data={{genesis:{{crafter:{{placeholder:1b}}}}}}]'
    store result score @s genesis.crafter.item_count if items block ~ ~-1 ~ container.* *


function ~/result_has_been_removed:
    function ~/../recipes
    as @a[distance=..10] function ~/../result_has_been_removed_player:
        for slot in player_slots:
            if items entity @s slot *[custom_data~{genesis:{crafter:{placeholder:1b}}}] item replace entity @s slot from block ~ ~-1 ~ container.15
    as @e[type=minecraft:item,distance=..10] if items entity @s contents *[custom_data~{genesis:{crafter:{placeholder:1b}}}] item replace entity @s contents from block ~ ~-1 ~ container.15
    raw ("item replace block ~ ~-1 ~ container.15 with white_stained_glass_pane[item_model=red_stained_glass_pane,tooltip_display={hide_tooltip:true},custom_data={genesis:{crafter:{placeholder:1b}}}]")
    tag @s remove genesis.crafter.has_output
    if entity @s[tag=genesis.crafter.reduce_durability_on_craft] return run function ~/../reduce_durability_on_craft:
        tag @s remove genesis.crafter.reduce_durability_on_craft
        for slot in input_slots:
            if items block ~ ~-1 ~ f'container.{slot}' *[damage] store result block ~ ~-1 ~ f'Items[{{Slot:{slot}b}}].components."minecraft:damage"' int -1 data get block ~ ~-1 ~ f'Items[{{Slot:{slot}b}}].components."minecraft:damage"' -1.0000000001
            if items block ~ ~-1 ~ f'container.{slot}' *[damage] unless data block ~ ~-1 ~ f'Items[{{Slot:{slot}b}}].components."minecraft:damage"' data modify block ~ ~-1 ~ f'Items[{{Slot:{slot}b}}].components."minecraft:damage"' set value 1 # Needed because default components are not on the item and execute store doesnt work
            unless items block ~ ~-1 ~ f'container.{slot}' *[damage] item modify block ~ ~-1 ~ f'container.{slot}' ~/../reduce_amount_by_1
    for slot in input_slots:
        item modify block ~ ~-1 ~ f'container.{slot}' ~/../reduce_amount_by_1


item_modifier ~/reduce_amount_by_1 {
    "function": "minecraft:set_count",
    "count": -1,
    "add": true
}


append function ~/recipes: # using append so order of exection while compiling won't matter
    return 0


def add_custom_recipe(recipe: list[list[str|type|None]], reduce_durability_instead = False):
    def decorator(output):
        command = "execute "
        slot = 2
        for line in recipe:
            for item in line:
                if item == None:
                    command += f'unless items block ~ ~-1 ~ container.{slot} * '
                elif type(item) == str:
                    command += f'if items block ~ ~-1 ~ container.{slot} {item} '
                else: # assume item is bolt-item
                    command += f'if items block ~ ~-1 ~ container.{slot} {item.base_item}[custom_data~{{bolt-item:{{id:"{item.namespace}:{item.id}"}}}}] '
                slot += 1
            slot += 6
        if type(output) == str:
            command += f'run return run item replace block ~ ~-1 ~ container.15 with {output}'
        else: # assume item is bolt-item
            loot_table = {"pools": [{"rolls": 1,"entries": [{"type": "minecraft:item","name": f'minecraft:{output.base_item}',"functions": [{"function": "minecraft:set_components","components": output.components}]}]}]}
            command += f'run return run loot replace block ~ ~-1 ~ container.15 loot {loot_table}'
        prepend function genesis:crafter/recipes:
            if reduce_durability_instead:
                tag @s add genesis.crafter.reduce_durability_on_craft
            raw command
            if reduce_durability_instead:
                tag @s remove genesis.crafter.reduce_durability_on_craft # Done before and after so the ordering doesn't matter and we don't need to check the items twice
        return output
    return decorator


@add_custom_recipe(recipe=[
    ['#logs','#logs','#logs'],
    ['#logs', None  ,'#logs'],
    ['#logs','#logs','#logs'],
])
@add_loot_table
@bolt_item
class Crafter(GenesisItem):
    item_name = ("Genesis Crafter", {})
    item_model = "crafting_table"
    rarity = "common"
    category = ["crafting_station"]

    base_item = "player_head"
    removed_components = ["equippable"]

    @on_place
    def place_crafter():
        setblock ~ ~ ~ barrel[]{CustomName:{"text":"Genesis Crafter"}}
        align xyz positioned ~.5 ~1 ~.5 summon item_display:
            tag @s add genesis.crafter


recipe genesis:item/crafting_station/crafter {
    "type": "minecraft:crafting_shaped",
    "category": "misc",
    "pattern": [
        "lll",
        "l l",
        "lll"
    ],
    "key": {
        "l": "#logs"
    },
    "result": {
        "id": Crafter.base_item,
        "components": Crafter.components
    }
}
