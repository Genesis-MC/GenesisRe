from genesis:utils import constant
from genesis:mapping import item_display_uuid

advancement ~/adjust_cooldown {
    "criteria": { "criteria": {
    "trigger": "minecraft:using_item", "conditions": {
    "item": { "predicates": { "minecraft:custom_data": {
        "genesis": { "right_click_ability": {}}
    }}}}}},
    "rewards": { "function": "genesis:right_click_ability/adjust_cooldown" }
}


function ~/adjust_cooldown:
    advancement revoke @s only ~/
    if items entity @s weapon.mainhand *[custom_data~{genesis:{right_click_ability:{}}}] function ~/../adjust_mainhand:
        store result score .cooldown genesis data get entity @s SelectedItem.components.minecraft:custom_data.genesis.right_click_ability.cooldown 1000
        store result score .previously_reduced_cooldown genesis data get entity @s SelectedItem.components.minecraft:use_cooldown.seconds 1000

        scoreboard players operation .cooldown genesis /= constant(2) genesis

        if score .cooldown genesis = .previously_reduced_cooldown genesis return 0

        item replace entity item_display_uuid["hex"] contents from entity @s weapon.mainhand
        store result entity item_display_uuid["hex"] item.components.minecraft:use_cooldown.seconds float 0.001 scoreboard players get .cooldown genesis
        item replace entity @s weapon.mainhand with air
        item replace entity @s weapon.mainhand from entity item_display_uuid["hex"] contents


    unless items entity @s weapon.mainhand *[custom_data~{genesis:{right_click_ability:{}}}] function ~/../adjust_offhand:
        store result score .cooldown genesis data get entity @s equipment.offhand.components.minecraft:custom_data.genesis.right_click_ability.cooldown 1000
        store result score .previously_reduced_cooldown genesis data get entity @s equipment.offhand.components.minecraft:use_cooldown.seconds 1000

        scoreboard players operation .cooldown genesis /= constant(2) genesis

        if score .cooldown genesis = .previously_reduced_cooldown genesis return 0

        item replace entity item_display_uuid["hex"] contents from entity @s weapon.mainhand
        store result entity item_display_uuid["hex"] item.components.minecraft:use_cooldown.seconds float 0.001 scoreboard players get .cooldown genesis
        item replace entity @s weapon.mainhand with air
        item replace entity @s weapon.mainhand from entity item_display_uuid["hex"] contents
