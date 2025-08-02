#> THIS FILE IS FOR ABILITIES WHICH PERSIST FOR A SPECIFIC DURATION AND NEED TO BE KEPT TRACK OF VIA SCHEDULED FUNCTIONS
from genesis:utils import constant, hitbox
from genesis:mana import add_mana, reduce_mana_or_return
from genesis:relation import ensure_id, prepare_id_inline, prepare_id, match_id, prepare_team, set_prepared_team, prepare_team_inline, match_team

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
            playsound minecraft:block.note_block.chime player @a ~ ~ ~ 1 1
            execute if entity @e[tag=genesis.temp,limit=1,distance=..2] run scoreboard players set @s c.heal 30000
            execute if entity @e[tag=genesis.temp,limit=1,distance=..2] run function custom_heal:apply_heal
            execute if entity @e[tag=genesis.temp,limit=1,distance=..2] run particle minecraft:heart ~ ~1 ~ 0.5 0.5 0.5 0 10
        # Revitalize 2
        execute if entity @s[tag=genesis.ability.revitalize2] on target at @s function ~/../revitalize_2:
            playsound minecraft:block.note_block.chime player @a ~ ~ ~ 1 1
            execute if entity @e[tag=genesis.temp,limit=1,distance=..3] run scoreboard players set @s c.heal 50000
            execute if entity @e[tag=genesis.temp,limit=1,distance=..3] run function custom_heal:apply_heal
            execute if entity @e[tag=genesis.temp,limit=1,distance=..3] run particle minecraft:heart ~ ~1 ~ 0.5 0.5 0.5 0 10
        # Revitalize 3
        execute if entity @s[tag=genesis.ability.revitalize3] on target at @s function ~/../revitalize_3:
            playsound minecraft:block.note_block.chime player @a ~ ~ ~ 1 1
            execute if entity @e[tag=genesis.temp,limit=1,distance=..4] run scoreboard players set @s c.heal 80000
            execute if entity @e[tag=genesis.temp,limit=1,distance=..4] run function custom_heal:apply_heal
            execute if entity @e[tag=genesis.temp,limit=1,distance=..4] run particle minecraft:heart ~ ~1 ~ 0.5 0.5 0.5 0 10
        kill @s

    # --Persistant Cosmetics-- #
    execute as @e[tag=genesis.ability.persist_sec] run scoreboard players add @s genesis 1
    execute as @e[tag=genesis.ability.persist_sec] if score @s genesis matches 2.. run kill @s
    

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
            execute unless score #temp genesis = constant(0) genesis on target at @s run playsound minecraft:block.note_block.chime player @a ~ ~ ~ 1 1
            kill @s
    execute as @e[type=item_display,tag=genesis.ability.voidcage_flair] function ~/../void_cage_spike_tick:
        scoreboard players add @s genesis 1
        execute if score @s genesis matches 42.. run kill @s

    # --Delta Flow-- #
    execute as @e[type=#genesis:marker_item_display,tag=genesis.ability.magma_spike] at @s function ~/../delta_flow_tick:
        scoreboard players add @s genesis 1
        execute if entity @s[tag=genesis.ability.magma_spike_marker1] if score @s genesis matches 2 function ~/../delta_flow_spawnspike2:
            playsound genesis:ability.delta_flow.burst player @a ~ ~ ~ 0.3 1.1
            particle dust_pillar{block_state:"blackstone"} ~ ~-0.7 ~ 0.6 0 0.6 0 40
            summon item_display ~ ~ ~ {Tags:["genesis.ability.magma_spike","genesis.ability.magma_spike2"],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.5f,1.5f,1.5f]},item:{id:"minecraft:dead_bush",count:1,components:{"minecraft:item_model":"genesis:ability/basalt_spike"}}}
            tp @e[type=item_display,tag=genesis.ability.magma_spike2,limit=1,sort=nearest] @s
            prepare_id('@s','genesis.relation.owner')
            prepare_team()
            with hitbox(1.1, f'@e[predicate=!{match_team}]'):
                data merge entity @s {Motion:[0d,0.7d,0d]}
        execute if entity @s[tag=genesis.ability.magma_spike_marker2] if score @s genesis matches 3 function ~/../delta_flow_spawnspike3:
            playsound genesis:ability.delta_flow.burst player @a ~ ~ ~ 0.3 0.9
            particle dust_pillar{block_state:"blackstone"} ~ ~-0.7 ~ 0.8 0 0.8 0 40
            summon item_display ~ ~ ~ {Tags:["genesis.ability.magma_spike","genesis.ability.magma_spike3"],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]},item:{id:"minecraft:dead_bush",count:1,components:{"minecraft:item_model":"genesis:ability/basalt_spike"}}}
            tp @e[type=item_display,tag=genesis.ability.magma_spike3,limit=1,sort=nearest] @s
            prepare_id('@s','genesis.relation.owner')
            prepare_team()
            with hitbox(2.1, f'@e[predicate=!{match_team}]'):
                data merge entity @s {Motion:[0d,0.9d,0d]}
        execute if entity @s[tag=genesis.ability.magma_spike_marker3] if score @s genesis matches 4 function ~/../delta_flow_spawnspike4:
            playsound genesis:ability.delta_flow.burst player @a ~ ~ ~ 0.3 0.6
            particle dust_pillar{block_state:"blackstone"} ~ ~-0.7 ~ 1 0 1 0 50
            summon item_display ~ ~ ~ {Tags:["genesis.ability.magma_spike","genesis.ability.magma_spike4"],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[3f,3f,3f]},item:{id:"minecraft:dead_bush",count:1,components:{"minecraft:item_model":"genesis:ability/basalt_spike"}}}
            tp @e[type=item_display,tag=genesis.ability.magma_spike4,limit=1,sort=nearest] @s
            prepare_id('@s','genesis.relation.owner')
            prepare_team()
            with hitbox(3.1, f'@e[predicate=!{match_team}]'):
                data merge entity @s {Motion:[0d,1d,0d]}
        execute if score @s genesis matches 5.. run return run kill @s

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
        tp @s ~ ~ ~ ~35 ~
        particle minecraft:sweep_attack ^ ^ ^2 0 0 0 0 1
        particle minecraft:sweep_attack ^ ^ ^3 0 0 0 0 1
        particle minecraft:sweep_attack ^ ^ ^4 0 0 0 0 1
        particle minecraft:crit ^ ^ ^3 0.6 0 0.6 0 12
        execute if score @s genesis matches 1 run return run playsound entity.player.attack.sweep player @a ~ ~ ~ 1 0.8
        execute if score @s genesis matches 4 run return run playsound entity.player.attack.sweep player @a ~ ~ ~ 1 0.8
        execute if score @s genesis matches 7 run return run playsound entity.player.attack.sweep player @a ~ ~ ~ 1 0.8
        execute if score @s genesis matches 10.. run kill @s
    

append function genesis:load:
    function genesis:persistant_abilities/sectick
    function genesis:persistant_abilities/10tick
    function genesis:persistant_abilities/5tick