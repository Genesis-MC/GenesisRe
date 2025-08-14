#####################################################################
# util/color/hsv_to_int.mcfunction
# written by Eroxen
#
# Converts the color in hsv format to minecraft int.
#
# Storage input:
# - genesis:temp util.color.hsv: array of 3 floats in range [0,1]
#
# Storage output :
# - genesis:temp util.color.int: int in range [0,16777216)
#####################################################################
from genesis:utils import constant

execute store result score #util.color.hue genesis run data get storage genesis:temp util.color.hsv[0] 360000
execute store result score #util.color.saturation genesis run data get storage genesis:temp util.color.hsv[1] 1000
execute store result score #util.color.value genesis run data get storage genesis:temp util.color.hsv[2] 1000

scoreboard players operation #util.color.c genesis = #util.color.saturation genesis
scoreboard players operation #util.color.c genesis *= #util.color.value genesis
scoreboard players operation #util.color.c genesis /= constant(1000) genesis

scoreboard players operation #util.color.x genesis = #util.color.hue genesis
scoreboard players operation #util.color.x genesis /= constant(60) genesis
scoreboard players operation #util.color.x genesis %= constant(2000) genesis
scoreboard players remove #util.color.x genesis 1000
execute if score #util.color.x genesis matches 1.. run scoreboard players operation #util.color.x genesis *= constant(-1) genesis
scoreboard players add #util.color.x genesis 1000
scoreboard players operation #util.color.x genesis *= #util.color.c genesis
scoreboard players operation #util.color.x genesis /= constant(1000) genesis

scoreboard players set #util.color.r genesis 0
scoreboard players set #util.color.g genesis 0
scoreboard players set #util.color.b genesis 0

scoreboard players operation #util.color.temp genesis = #util.color.hue genesis
scoreboard players operation #util.color.temp genesis /= constant(60000) genesis
execute if score #util.color.temp genesis matches 0 run scoreboard players operation #util.color.r genesis = #util.color.c genesis
execute if score #util.color.temp genesis matches 0 run scoreboard players operation #util.color.g genesis = #util.color.x genesis
execute if score #util.color.temp genesis matches 1 run scoreboard players operation #util.color.r genesis = #util.color.x genesis
execute if score #util.color.temp genesis matches 1 run scoreboard players operation #util.color.g genesis = #util.color.c genesis

execute if score #util.color.temp genesis matches 2 run scoreboard players operation #util.color.g genesis = #util.color.c genesis
execute if score #util.color.temp genesis matches 2 run scoreboard players operation #util.color.b genesis = #util.color.x genesis
execute if score #util.color.temp genesis matches 3 run scoreboard players operation #util.color.g genesis = #util.color.x genesis
execute if score #util.color.temp genesis matches 3 run scoreboard players operation #util.color.b genesis = #util.color.c genesis

execute if score #util.color.temp genesis matches 4 run scoreboard players operation #util.color.r genesis = #util.color.x genesis
execute if score #util.color.temp genesis matches 4 run scoreboard players operation #util.color.b genesis = #util.color.c genesis
execute if score #util.color.temp genesis matches 5 run scoreboard players operation #util.color.r genesis = #util.color.c genesis
execute if score #util.color.temp genesis matches 5 run scoreboard players operation #util.color.b genesis = #util.color.x genesis

scoreboard players operation #util.color.temp genesis = #util.color.value genesis
scoreboard players operation #util.color.temp genesis -= #util.color.c genesis
scoreboard players operation #util.color.r genesis += #util.color.temp genesis
scoreboard players operation #util.color.g genesis += #util.color.temp genesis
scoreboard players operation #util.color.b genesis += #util.color.temp genesis


scoreboard players operation #util.color.r genesis *= constant(256) genesis
scoreboard players operation #util.color.g genesis *= constant(256) genesis
scoreboard players operation #util.color.b genesis *= constant(256) genesis
scoreboard players add #util.color.r genesis 500
scoreboard players add #util.color.g genesis 500
scoreboard players add #util.color.b genesis 500
scoreboard players operation #util.color.r genesis /= constant(1000) genesis
scoreboard players operation #util.color.g genesis /= constant(1000) genesis
scoreboard players operation #util.color.b genesis /= constant(1000) genesis
scoreboard players remove #util.color.r genesis 1
scoreboard players remove #util.color.g genesis 1
scoreboard players remove #util.color.b genesis 1
execute unless score #util.color.r genesis matches 0..255 run scoreboard players set #util.color.r genesis 0
execute unless score #util.color.g genesis matches 0..255 run scoreboard players set #util.color.g genesis 0
execute unless score #util.color.b genesis matches 0..255 run scoreboard players set #util.color.b genesis 0

scoreboard players operation #util.color.int genesis = #util.color.r genesis
scoreboard players operation #util.color.int genesis *= constant(256) genesis
scoreboard players operation #util.color.int genesis += #util.color.g genesis
scoreboard players operation #util.color.int genesis *= constant(256) genesis
scoreboard players operation #util.color.int genesis += #util.color.b genesis

execute store result storage genesis:temp util.color.int int 1 run scoreboard players get #util.color.int genesis
