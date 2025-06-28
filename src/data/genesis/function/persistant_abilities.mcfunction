#> THIS FILE IS FOR ABILITIES WHICH PERSIST FOR A SPECIFIC DURATION AND NEED TO BE KEPT TRACK OF VIA SCHEDULED FUNCTIONS
from genesis:utils import constant
from genesis:mana import add_mana, reduce_mana_or_return

function ~/sectick:
    schedule function ~/ 1s

function ~/10tick:
    schedule function ~/ 10t

function ~/5tick:
    schedule function ~/ 5t

append function ~/sectick:
    # --Revitalize-- #
    execute as @e[type=interaction,tag=genesis.ability.revitalize] run scoreboard players add @s genesis 1
    execute as @e[type=interaction,tag=genesis.ability.revitalize] if score @s genesis matches 4.. function ~/../revitalize_finish:
        tag @s add genesis.temp
        # Revitalize 1
        execute if entity @s[tag=genesis.ability.revitalize1] on target at @s function ~/../revitalize_1:
            execute if entity @e[tag=genesis.temp,limit=1,distance=..2] run scoreboard players set @s c.heal 30000
            execute if entity @e[tag=genesis.temp,limit=1,distance=..2] run function custom_heal:apply_heal
            execute if entity @e[tag=genesis.temp,limit=1,distance=..2] run particle minecraft:heart ~ ~1 ~ 0.5 0.5 0.5 0 10
        # Revitalize 2
        execute if entity @s[tag=genesis.ability.revitalize2] on target at @s function ~/../revitalize_2:
            execute if entity @e[tag=genesis.temp,limit=1,distance=..3] run scoreboard players set @s c.heal 50000
            execute if entity @e[tag=genesis.temp,limit=1,distance=..3] run function custom_heal:apply_heal
            execute if entity @e[tag=genesis.temp,limit=1,distance=..3] run particle minecraft:heart ~ ~1 ~ 0.5 0.5 0.5 0 10
        # Revitalize 3
        execute if entity @s[tag=genesis.ability.revitalize3] on target at @s function ~/../revitalize_3:
            execute if entity @e[tag=genesis.temp,limit=1,distance=..4] run scoreboard players set @s c.heal 80000
            execute if entity @e[tag=genesis.temp,limit=1,distance=..4] run function custom_heal:apply_heal
            execute if entity @e[tag=genesis.temp,limit=1,distance=..4] run particle minecraft:heart ~ ~1 ~ 0.5 0.5 0.5 0 10
        kill @s

    # --Lifeline-- #
    effect give @a[tag=genesis.passive.lifeline] regeneration 2 0 true

    # --Nightfall-- #
    execute if predicate genesis:is_night run effect give @a[tag=genesis.passive.nightfall] strength 2 0 true

    # --Persistant Cosmetics-- #
    execute as @e[tag=genesis.ability.persist_sec] run scoreboard players add @s genesis 1
    execute as @e[tag=genesis.ability.persist_sec] if score @s genesis matches 2.. run kill @s

append function ~/10tick:
    # --Polar Vortex-- #
    execute as @a[tag=genesis.ability.polar_vortex] at @s function ~/../polar_vortex_tick:
        reduce_mana_or_return(amount = 2000)
        execute positioned ~ ~0.1 ~ run function genesis:utils/particles/circle_rad6 {particle:"snowflake", ydirection:1, speed:0.3}
        summon area_effect_cloud ~ ~-2 ~ {Tags:["genesis.ability.polar_vortex_particle"],custom_particle:{type:"block_crumble",block_state:"minecraft:ice"},Radius:2f,Duration:40}
        tag @s add genesis.caster
        # Frostbite
        execute as @e[distance=..6,tag=!genesis.player,type=!#genesis:non_living] function ~/../polar_vortex_frostbite:
            scoreboard players add @s genesis.passive.frostbite 1
            execute anchored eyes run particle minecraft:snowflake ^ ^ ^ 0.5 0.5 0.5 0 5
            effect give @s slowness 1 0 true
            execute if score @s genesis.passive.frostbite matches 10.. at @s function ~/../polar_vortex_frostbite_trigger:
                playsound block.glass.break player @a ~ ~ ~ 1 1
                playsound entity.player.hurt_freeze player @a ~ ~ ~ 1 1
                execute anchored eyes run particle minecraft:block{block_state:"minecraft:ice"} ^ ^ ^ 0.6 0.5 0.6 0 40
                summon item_display ~ ~ ~ {Tags:["genesis.ability.persist_sec"],Rotation:[0F,90F],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.2f,1.2f,0.01f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"genesis:ability/frostbite"}}}
                damage @s 8 minecraft:generic by @a[tag=genesis.caster,limit=1]
                effect give @s minecraft:slowness 2 4 true
                scoreboard players reset @s genesis.passive.frostbite
        tag @s remove genesis.caster
        execute if score @s genesis.mana.current matches ..1999 run tag @s remove genesis.ability.polar_vortex

append function ~/5tick:
    # --Void Cage-- #
    execute as @e[type=interaction,tag=genesis.ability.voidcage] at @s function ~/../void_cage_tick:
        scoreboard players add @s genesis 1
        function genesis:utils/particles/transition_circle {particle:"portal", ydirection:0, speed:2.5}
        function genesis:utils/particles/circle_rad5 {particle:"witch", ydirection:1, speed:0.3}
        teleport @e[distance=4..6,type=!#genesis:non_living,tag=!genesis.player] @s
        execute if score @s genesis matches 40.. function ~/../void_cage_finish:
            scoreboard players set #temp genesis 0
            execute as @e[distance=..4,type=!#genesis:non_living,tag=!genesis.player] run scoreboard players add #temp genesis 10000
            execute on target run scoreboard players operation @s c.heal = #temp genesis
            execute on target run function custom_heal:apply_heal
            execute unless score #temp genesis = constant(0) genesis on target at @s run particle minecraft:heart ~ ~1 ~ 0.5 0.5 0.5 0 10
            kill @s
    execute as @e[type=item_display,tag=genesis.ability.voidcage_flair] function ~/../void_cage_spike_tick:
        scoreboard players add @s genesis 1
        execute if score @s genesis matches 42.. run kill @s

append function genesis:tick:
    # --Cryorazor-- # 
    execute as @a[tag=genesis.ability.cryorazor] run tag @s remove genesis.ability.cryorazor
    execute as @e[type=item_display,tag=genesis.ability.cryorazor] at @s function genesis:persistant_abilities/cryorazor:
        particle minecraft:trial_spawner_detection_ominous ~ ~ ~ 0 0 0 0 2
        scoreboard players add @s genesis 3
        execute if score @s genesis matches 150.. run kill @s
        execute as @e[distance=..2,tag=!genesis.player] run damage @s 4 minecraft:generic
        execute store result storage genesis:temp item.cryorazor.distance float 0.01 run scoreboard players get @s genesis
        execute function genesis:persistant_abilities/cryorazor_macro with storage genesis:temp item.cryorazor:
            $execute rotated ~ 0 run teleport @s ^ ^ ^$(distance) ~12 90

    # --Persistant Cosmetics-- #
    execute as @e[type=area_effect_cloud,tag=genesis.ability.polar_vortex_particle] at @s function genesis:persistant_abilities/polar_vortex_particle:
        tp @s ~ ~0.12 ~ ~8 ~
        particle minecraft:end_rod ^ ^ ^2 0 0 0 0 1
        particle minecraft:trial_spawner_detection_ominous ^ ^ ^-2 0 0 0 0 1
        particle minecraft:end_rod ^ ^ ^-4 0 0 0 0 1
        particle minecraft:trial_spawner_detection_ominous ^ ^ ^4 0 0 0 0 1
    execute as @e[type=area_effect_cloud,tag=genesis.ability.revitalize_particle] at @s function genesis:persistant_abilities/revitalize_particle:
        tp @s ~ ~ ~ ~6 ~
        particle minecraft:happy_villager ^ ^ ^2 0 0 0 0 1
    execute as @e[type=marker,tag=genesis.ability.cleave_particle] at @s function genesis:persistant_abilities/cleave_particle:
        scoreboard players add @s genesis 1
        tp @s ~ ~ ~ ~10 ~
        particle minecraft:sweep_attack ^ ^ ^2 0 0 0 0 1
        particle minecraft:sweep_attack ^ ^ ^3 0 0 0 0 1
        particle minecraft:sweep_attack ^ ^ ^4 0 0 0 0 1
        execute if score @s genesis matches 20.. run kill @s
    

append function genesis:load:
    function genesis:persistant_abilities/sectick
    function genesis:persistant_abilities/10tick
    function genesis:persistant_abilities/5tick