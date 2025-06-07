#> THIS FILE IS FOR ABILITIES WHICH PERSIST FOR A SPECIFIC DURATION AND NEED TO BE KEPT TRACK OF VIA SCHEDULED FUNCTIONS
from genesis:utils import constant
from genesis:mana import add_mana, reduce_mana_or_return

function genesis:right_click_ability/persistant_abilities/sectick:
    schedule function genesis:right_click_ability/persistant_abilities/sectick 1s

function genesis:right_click_ability/persistant_abilities/10tick:
    schedule function genesis:right_click_ability/persistant_abilities/10tick 10t

function genesis:right_click_ability/persistant_abilities/5tick:
    schedule function genesis:right_click_ability/persistant_abilities/5tick 5t

append function genesis:right_click_ability/persistant_abilities/10tick:
    # Polar Vortex
    execute as @a[tag=genesis.ability.polar_vortex]:
        execute if score @s genesis.mana.current matches 2000.. at @s:
            execute as @e[distance=..6,tag=!genesis.player,tag=!non_living] run scoreboard players add @s genesis.passive.frostbite 1
        
            scoreboard players add @s genesis.passive.frostbite 1
            execute anchored eyes run particle minecraft:snowflake ^ ^ ^ 0.5 0.5 0.5 0 10
            execute if score @s genesis.passive.frostbite matches 10..:
                playsound block.glass.break player @a ~ ~ ~ 1 1
                playsound entity.player.hurt_freeze player @a ~ ~ ~ 1 1
                execute anchored eyes positioned ^ ^ ^ run function genesis:utils/particles/transition_circle {particle:"snowflake", ydirection:-1, speed:0.05}
                execute anchored eyes run particle minecraft:block{block_state:"minecraft:ice"} ^ ^ ^ 0.5 0.5 0.5 0 20
                execute on attacker run tag @s add genesis.caster
                damage @s 8 minecraft:generic by @a[tag=genesis.caster,limit=1]
                effect give @s minecraft:slowness 2 4 true
                scoreboard players reset @s genesis.passive.frostbite
                execute on attacker run tag @s remove genesis.caster

            reduce_mana_or_return(amount = 2000)
        execute unless score @s genesis.mana.current matches 2000..:
            tag @s remove genesis.ability.polar_vortex

append function genesis:right_click_ability/persistant_abilities/5tick:
    # Void Cage
    execute as @e[type=interaction,tag=genesis.ability.voidcage] at @s:
        scoreboard players add @s genesis.ability.void_cage_duration 1
        function genesis:utils/particles/transition_circle {particle:"portal", ydirection:0, speed:2.5}
        function genesis:utils/particles/circle_rad5 {particle:"witch", ydirection:1, speed:0.3}
        teleport @e[distance=4..6,tag=!genesis.player,tag=!non_living,tag=!genesis.static] @s
        execute if score @s genesis.ability.void_cage_duration matches 40..:
            scoreboard players set #temp genesis 0
            execute as @e[distance=..4,tag=!genesis.player,tag=!non_living,tag=!genesis.ability.voidcage] run scoreboard players add #temp genesis 10000
            execute on target run scoreboard players operation @s c.heal = #temp genesis
            execute on target run function custom_heal:apply_heal
            execute unless score #temp genesis = constant(0) genesis on target at @s run particle minecraft:heart ~ ~1 ~ 0.5 0.5 0.5 0 10
            kill @s
    execute as @e[type=item_display,tag=genesis.ability.voidcage_flair]:
        scoreboard players add @s genesis.ability.void_cage_duration 1
        execute if score @s genesis.ability.void_cage_duration matches 42.. run kill @s

function genesis:right_click_ability/persistant_abilities/sectick
function genesis:right_click_ability/persistant_abilities/10tick
function genesis:right_click_ability/persistant_abilities/5tick