from ps_beet_bolt.bolt_item import event_decorator
from genesis:utils import add_translation, break_text_into_lines, camel_case_to_snake_case
from genesis:tungsten import add_tungsten_components
from genesis:mapping import rarity_text_color
from genesis:mana import reduce_mana_or_return
from genesis:utils import constant


def right_click_ability(name: str, description: str, cooldown: float, mana = 0, charge_time = 0.05, charge_sound = {sound_id:""}, charge_animation = "none"):
    @event_decorator
    def decorator(func, item):
        # Add ability description to lore
        active_name_id = camel_case_to_snake_case(name)
        trans_key = f'item.{item.namespace}.{item.id}.{active_name_id}'
        add_translation(trans_key, name)

        trailing_new_line = []
        if item.get("passives"):
            trailing_new_line = [""]

        active_ability_cost_line = [{"translate":"text.genesis.active_ability","color":"dark_gray"},{"text":" [","italic":false}]

        if mana:
            active_ability_cost_line += [{"text":"\u0049","color":"white","italic":false,"font":"genesis:icon"},{"text":" "+str(mana),"italic":false,"color":rarity_text_color["rare"]}]

        if cooldown:
            if mana:
                active_ability_cost_line += [{"text":" | ","color":"dark_gray"}]
            active_ability_cost_line += [{"text":"\u004A","color":"white","italic":false,"font":"genesis:icon"},{"text":" "+str(cooldown)+"s","italic":false,"color":rarity_text_color["uncommon"]}]

        active_ability_cost_line += [{"text":"]","italic":false}]

        item.merge("lore",
            [
                [{"text":"❂","color":rarity_text_color["transcendent"],"italic":false}," ",{"translate":trans_key,"color":"gold"}],
            ] +
            [active_ability_cost_line] +
            break_text_into_lines(
                description,
                f'item.{item.namespace}.{item.id}.{active_name_id}'
            ) +
            trailing_new_line
        )

        # Add consumable and use_cooldown components
        item.consumable = {"consume_seconds":charge_time,"animation":charge_animation,"has_consume_particles":false,"sound":charge_sound}
        item.use_cooldown = {"seconds":cooldown,"cooldown_group":f'{item.namespace}:right_click_ability/{item.id}'}

        # Add original cooldown to custom data
        item.merge("custom_data", {"genesis": {"right_click_ability": {"cooldown": cooldown, "mana": mana}}})

        # Add tungsten components
        add_tungsten_components(item, "mainhand")
        add_tungsten_components(item, "offhand")

        # Add function to be ran on consume
        consume_path = f'{item.namespace}:bolt-item/item/{item.id}/right_click_ability/{func.__name__}'

        advancement consume_path {"criteria": { "criteria": {
            "trigger": "minecraft:consume_item", "conditions": {
            "item": { "predicates": { "minecraft:custom_data": {
                "bolt-item": { "id": f'{item.namespace}:{item.id}' }
            }}}}}},
            "rewards": { "function": consume_path }
        }

        function consume_path:
            advancement revoke @s only consume_path
            unless items entity @s weapon.mainhand (item.base_item)[minecraft:custom_data~{bolt-item:{id:(f'{item.namespace}:{item.id}')}}] function genesis:right_click_ability/regive_offhand_macro with entity @s equipment.offhand
            if items entity @s weapon.mainhand (item.base_item)[minecraft:custom_data~{bolt-item:{id:(f'{item.namespace}:{item.id}')}}] function genesis:right_click_ability/regive_mainhand_macro with entity @s SelectedItem
            if mana:
                reduce_mana_or_return(mana * 200) #! add a way for the item to not go on full cooldown if mana isn't enough
            func()
    return decorator


append function genesis:load:
    scoreboard objectives add genesis.right_click_ability.required_mana.mainhand dummy
    scoreboard objectives add genesis.right_click_ability.required_mana.offhand dummy


append function_tag tungsten:swap/mainhand {"values":["genesis:right_click_ability/update_cooldown/swap_mainhand_check"]}
append function_tag tungsten:swap/offhand {"values":["genesis:right_click_ability/update_cooldown/swap_offhand_check"]}
append function_tag genesis:stat/update/ability_haste {"values":["genesis:right_click_ability/update_cooldown/ability_haste_check"]}
append function_tag genesis:mana/changed {"values":["genesis:right_click_ability/update_cooldown/mana_check"]}


function ~/update_cooldown/ability_haste_check:
    for slot, nbt_path in [("mainhand","SelectedItem"),("offhand","equipment.offhand")]:
        unless entity @s[tag=f'genesis.right_click_ability.not_enough_mana.{slot}'] if items entity @s f'weapon.{slot}' *[custom_data~{genesis:{'right_click_ability':{}}}] function ~/../ability_haste_{slot}:
            store result score .cooldown genesis data get entity @s f'{nbt_path}.components."minecraft:custom_data".genesis.right_click_ability.cooldown' 4000 # 20 * 100 = 4000
            store result score .previously_reduced_cooldown genesis data get entity @s f'{nbt_path}.components."minecraft:use_cooldown".seconds' 20

            # Calculate original cooldown reduced by ability haste
            # new = ( cooldown * 100 ) / ( 100 + haste )
            scoreboard players set #denominator genesis 100
            scoreboard players operation #denominator genesis += @s genesis.stat.ability_haste
            store result score #temp genesis scoreboard players operation .cooldown genesis /= #denominator genesis
            scoreboard players operation .cooldown genesis /= constant(2) genesis
            scoreboard players operation #temp genesis %= constant(2) genesis
            scoreboard players operation .cooldown genesis += #temp genesis

            if score .cooldown genesis = .previously_reduced_cooldown genesis return 0

            data modify storage genesis:temp 'right_click_ability'.use_cooldown set from entity @s f'{nbt_path}.components."minecraft:use_cooldown"'
            store result storage genesis:temp 'right_click_ability'.use_cooldown.seconds float 0.05 scoreboard players get .cooldown genesis
            execute function ~/../modify_{slot}_macro with storage genesis:temp 'right_click_ability':
                raw (f'$item modify entity @s weapon.{slot} {{"function":"minecraft:set_components","components":{{"minecraft:use_cooldown":$(use_cooldown)}}}}')


for slot, nbt_path in [("mainhand","SelectedItem"),("offhand","equipment.offhand")]:
    function ~/update_cooldown/swap_{slot}_check:
        if entity @s[tag=f'genesis.right_click_ability.item.{slot}'] function ~/../swap_{slot}_unequip:
            tag @s remove f'genesis.right_click_ability.item.{slot}'
            tag @s remove f'genesis.right_click_ability.not_enough_mana.{slot}'
            scoreboard players reset @s f'genesis.right_click_ability.required_mana.{slot}'

        if items entity @s f'weapon.{slot}' *[custom_data~{genesis:{'right_click_ability':{}}}] return run function ~/../swap_{slot}_equipped:
            tag @s add f'genesis.right_click_ability.item.{slot}'
            store result score @s f'genesis.right_click_ability.required_mana.{slot}' data get entity @s f'{nbt_path}.components."minecraft:custom_data".genesis.right_click_ability.mana' 200
            if score @s f'genesis.right_click_ability.required_mana.{slot}' > @s genesis.mana.current function ~/../mana_disable_{slot}
            unless score @s f'genesis.right_click_ability.required_mana.{slot}' > @s genesis.mana.current function ~/../mana_enable_{slot}


function ~/update_cooldown/mana_check:
    for slot, nbt_path in [("mainhand","SelectedItem"),("offhand","equipment.offhand")]:
        if entity @s[tag=f'genesis.right_click_ability.item.{slot}',tag=!f'genesis.right_click_ability.not_enough_mana.{slot}'] if score @s f'genesis.right_click_ability.required_mana.{slot}' > @s genesis.mana.current function ~/../mana_disable_{slot}:
            unless items entity @s f'weapon.{slot}' *[custom_data~{genesis:{'right_click_ability':{}}}] return run tag @s remove f'genesis.right_click_ability.item.{slot}'
            tag @s add f'genesis.right_click_ability.not_enough_mana.{slot}'
            # Set cooldown to 0.25s if you don't have enough mana
            data modify storage genesis:temp 'right_click_ability'.use_cooldown set from entity @s f'{nbt_path}.components."minecraft:use_cooldown"'
            data modify storage genesis:temp 'right_click_ability'.use_cooldown.seconds set value 0.25f
            execute function ~/../modify_{slot}_macro with storage genesis:temp 'right_click_ability'

        if entity @s[tag=f'genesis.right_click_ability.item.{slot}',tag=f'genesis.right_click_ability.not_enough_mana.{slot}'] unless score @s f'genesis.right_click_ability.required_mana.{slot}' > @s genesis.mana.current function ~/../mana_enable_{slot}:
            unless items entity @s f'weapon.{slot}' *[custom_data~{genesis:{'right_click_ability':{}}}] return run tag @s remove f'genesis.right_click_ability.item.{slot}'
            tag @s remove f'genesis.right_click_ability.not_enough_mana.{slot}'
            # Set cooldown to actual cooldown if you have enough mana now
            function ~/../ability_haste_{slot}


function ~/regive_mainhand_macro:
    item replace entity @s weapon.mainhand with air
    $loot replace entity @s weapon.mainhand loot {"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"$(id)","functions":[{"function":"minecraft:set_count","count":$(count)},{"function":"minecraft:set_components","components":$(components)}]}]}]}


function ~/regive_offhand_macro:
    item replace entity @s weapon.offhand with air
    $loot replace entity @s weapon.offhand loot {"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"$(id)","functions":[{"function":"minecraft:set_count","count":$(count)},{"function":"minecraft:set_components","components":$(components)}]}]}]}
