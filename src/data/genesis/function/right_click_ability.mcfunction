from genesis:utils import constant
from genesis:mapping import item_display_uuid


append function_tag tungsten:swap/mainhand {"values":["genesis:right_click_ability/set_reduced_cooldown_mainhand"]}
append function_tag tungsten:swap/offhand {"values":["genesis:right_click_ability/set_reduced_cooldown_offhand"]}
#! also have this run when the "ability haste" stat changes, this can only be implemented once the stat exists :)


function ~/set_reduced_cooldown_mainhand:
    unless items entity @s weapon.mainhand *[custom_data~{genesis:{right_click_ability:{}}}] return 0

    store result score .cooldown genesis data get entity @s SelectedItem.components.minecraft:custom_data.genesis.right_click_ability.cooldown 1000
    store result score .previously_reduced_cooldown genesis data get entity @s SelectedItem.components.minecraft:use_cooldown.seconds 1000

    scoreboard players operation .cooldown genesis /= constant(2) genesis

    if score .cooldown genesis = .previously_reduced_cooldown genesis return 0

    data modify storage genesis:temp right_click_ability.use_cooldown set from entity @s SelectedItem.components.minecraft:use_cooldown
    store result storage genesis:temp right_click_ability.use_cooldown.seconds float 0.001 scoreboard players get .cooldown genesis
    execute function ~/../modify_mainhand with storage genesis:temp right_click_ability:
        $item modify entity @s weapon.mainhand {"function":"minecraft:set_components","components":{"minecraft:use_cooldown":$(use_cooldown)}}


function ~/set_reduced_cooldown_offhand:
    unless items entity @s weapon.offhand *[custom_data~{genesis:{right_click_ability:{}}}] return 0

    store result score .cooldown genesis data get entity @s equipment.offhand.components.minecraft:custom_data.genesis.right_click_ability.cooldown 1000
    store result score .previously_reduced_cooldown genesis data get entity @s equipment.offhand.components.minecraft:use_cooldown.seconds 1000

    scoreboard players operation .cooldown genesis /= constant(2) genesis

    if score .cooldown genesis = .previously_reduced_cooldown genesis return 0

    data modify storage genesis:temp right_click_ability.use_cooldown set from entity @s equipment.offhand.components.minecraft:use_cooldown
    store result storage genesis:temp right_click_ability.use_cooldown.seconds float 0.001 scoreboard players get .cooldown genesis
    execute function ~/../modify_offhand with storage genesis:temp right_click_ability:
        $item modify entity @s weapon.offhand {"function":"minecraft:set_components","components":{"minecraft:use_cooldown":$(use_cooldown)}}


function ~/regive_mainhand:
    item replace entity item_display_uuid["hex"] contents from entity @s weapon.mainhand
    item replace entity @s weapon.mainhand with air
    item replace entity @s weapon.mainhand from entity item_display_uuid["hex"] contents


function ~/regive_offhand:
    item replace entity item_display_uuid["hex"] contents from entity @s weapon.offhand
    item replace entity @s weapon.offhand with air
    item replace entity @s weapon.offhand from entity item_display_uuid["hex"] contents
