from ps_beet_bolt.bolt_item import event_decorator, camel_case_to_snake_case
from tungsten:decorators import _add_tungsten_base, _add_tungsten_components
from genesis:utils import add_translation, break_text_into_lines
from genesis:mapping import item_display_uuid, rarity_text_color
from genesis:utils import constant


def right_click_ability(name: str, description: str, mana: float, cooldown: float, charge_time = 0.05, charge_sound = {sound_id:""}, charge_animation = "none"):
    @event_decorator
    def decorator(func, item):
        # Add ability description to lore
        active_name_id = camel_case_to_snake_case(name)
        trans_key = f'item.{item.namespace}.{item.id}.{active_name_id}'
        add_translation(trans_key, name)

        trailing_new_line = []
        if item.get("passives"):
            trailing_new_line = [{"text":"","color":"white"}] #! fix when fix

        item.merge("lore",
            [
                [{"text":"❂","color":rarity_text_color["transcendent"],"italic":false},{"text":" ","color":"white"},{"translate":trans_key,"color":"gold"}], #! fix after mc fixes bug
                [
                    {"translate":"text.genesis.active_ability","color":"dark_gray"},{"text":" [","italic":false},
                    {"translate":"icon.genesis.mana","color":"white","italic":false,"font":"genesis:icon"},{"text":" "+str(mana),"italic":false,"color":rarity_text_color["rare"]},
                    {"text":" | ","color":"dark_gray"},
                    {"translate":"icon.genesis.cooldown","color":"white","italic":false,"font":"genesis:icon"},{"text":" "+str(cooldown)+"s","italic":false,"color":rarity_text_color["uncommon"]},
                    {"text":"]","italic":false},
                ],
            ] +
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
        item.merge("custom_data", {"genesis": {"right_click_ability": {"cooldown": cooldown}}})

        # Add tungsten components
        _add_tungsten_base()
        _add_tungsten_components(item, "mainhand")
        _add_tungsten_components(item, "offhand")

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
            #! add mana cost logic here once mana ... exists :D
            unless items entity @s weapon.mainhand (item.base_item)[minecraft:custom_data~{bolt-item:{id:(f'{item.namespace}:{item.id}')}}] function genesis:right_click_ability/regive_offhand
            if items entity @s weapon.mainhand (item.base_item)[minecraft:custom_data~{bolt-item:{id:(f'{item.namespace}:{item.id}')}}] function genesis:right_click_ability/regive_mainhand
            func()
    return decorator


append function_tag tungsten:swap/mainhand {"values":["genesis:right_click_ability/set_reduced_cooldown_mainhand"]}
append function_tag tungsten:swap/offhand {"values":["genesis:right_click_ability/set_reduced_cooldown_offhand"]}
#! also have this run when the "ability haste" stat changes, this can only be implemented once the stat exists :)


function ~/set_reduced_cooldown_mainhand:
    unless items entity @s weapon.mainhand *[custom_data~{genesis:{'right_click_ability':{}}}] return 0

    store result score .cooldown genesis data get entity @s SelectedItem.components.minecraft:custom_data.genesis.right_click_ability.cooldown 1000
    store result score .previously_reduced_cooldown genesis data get entity @s SelectedItem.components.minecraft:use_cooldown.seconds 1000

    scoreboard players operation .cooldown genesis /= constant(2) genesis

    if score .cooldown genesis = .previously_reduced_cooldown genesis return 0

    data modify storage genesis:temp 'right_click_ability'.use_cooldown set from entity @s SelectedItem.components.minecraft:use_cooldown
    store result storage genesis:temp 'right_click_ability'.use_cooldown.seconds float 0.001 scoreboard players get .cooldown genesis
    execute function ~/../modify_mainhand with storage genesis:temp 'right_click_ability':
        $item modify entity @s weapon.mainhand {"function":"minecraft:set_components","components":{"minecraft:use_cooldown":$(use_cooldown)}}


function ~/set_reduced_cooldown_offhand:
    unless items entity @s weapon.offhand *[custom_data~{genesis:{'right_click_ability':{}}}] return 0

    store result score .cooldown genesis data get entity @s equipment.offhand.components.minecraft:custom_data.genesis.right_click_ability.cooldown 1000
    store result score .previously_reduced_cooldown genesis data get entity @s equipment.offhand.components.minecraft:use_cooldown.seconds 1000

    scoreboard players operation .cooldown genesis /= constant(2) genesis

    if score .cooldown genesis = .previously_reduced_cooldown genesis return 0

    data modify storage genesis:temp 'right_click_ability'.use_cooldown set from entity @s equipment.offhand.components.minecraft:use_cooldown
    store result storage genesis:temp 'right_click_ability'.use_cooldown.seconds float 0.001 scoreboard players get .cooldown genesis
    execute function ~/../modify_offhand with storage genesis:temp 'right_click_ability':
        $item modify entity @s weapon.offhand {"function":"minecraft:set_components","components":{"minecraft:use_cooldown":$(use_cooldown)}}


function ~/regive_mainhand:
    item replace entity item_display_uuid["hex"] contents from entity @s weapon.mainhand
    item replace entity @s weapon.mainhand with air
    item replace entity @s weapon.mainhand from entity item_display_uuid["hex"] contents


function ~/regive_offhand:
    item replace entity item_display_uuid["hex"] contents from entity @s weapon.offhand
    item replace entity @s weapon.offhand with air
    item replace entity @s weapon.offhand from entity item_display_uuid["hex"] contents
