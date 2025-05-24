#> THIS FILE IS FOR ABILITIES WHICH PERSIST FOR A SPECIFIC DURATION AND NEED TO BE KEPT TRACK OF VIA SCHEDULED FUNCTIONS
from genesis:utils import constant

function genesis:sectick:
    schedule function genesis:sectick 1s

function genesis:5tick:
    schedule function genesis:5tick 5t

append function genesis:5tick:
    execute as @e[type=interaction,tag=genesis.ability.voidcage] at @s:
        scoreboard players add @s genesis.ability.void_cage_duration 1
        function genesis:utils/particles/transition_circle {particle:"portal", ydirection:0, speed:2.5}
        function genesis:utils/particles/circle_rad5 {particle:"witch", ydirection:1, speed:0.2}
        teleport @e[distance=4..6,tag=!genesis.player,tag=!non_living] @s
        execute if score @s genesis.ability.void_cage_duration >= constant(40) genesis:
            scoreboard players set #temp genesis 0
            execute as @e[distance=..4,tag=!genesis.player,tag=!non_living,tag=!genesis.ability.voidcage] run scoreboard players add #temp genesis 10000
            execute on target run scoreboard players operation @s c.heal = #temp genesis
            execute on target run function custom_heal:apply_heal
            execute unless score #temp genesis = constant(0) genesis on target at @s run particle minecraft:heart ~ ~1 ~ 0.5 0.5 0.5 0 10
            kill @s

function genesis:5tick
function genesis:sectick