from genesis:player import PerPlayerStorage
from genesis:utils import constant


def reduce_mana_or_return(amount: int, update = True): # This is actual mana, so 20x higher than the mana_pool stat and the mana communicated to the player
    if score @s genesis.mana.current matches (None, amount - 1) return 0
    if score @s genesis.mana.current = @s genesis.mana.max scoreboard players add @s genesis.hud.display 1
    if score @s genesis.mana.current = @s genesis.mana.max tag @s add genesis.hud.display
    scoreboard players remove @s genesis.mana.current (amount)
    if update:
        function #genesis:mana/changed
        function genesis:mana/update_hud


def reduce_mana_by_score_or_return(name: str, objective: str, update = True): # This is actual mana, so 20x higher than the mana_pool stat and the mana communicated to the player
    raw (f'execute if score {name} {objective} > @s genesis.mana.current run return 0')
    if score @s genesis.mana.current = @s genesis.mana.max scoreboard players add @s genesis.hud.display 1
    if score @s genesis.mana.current = @s genesis.mana.max tag @s add genesis.hud.display
    raw (f'scoreboard players operation @s genesis.mana.current -= {name} {objective}')
    if update:
        function #genesis:mana/changed
        function genesis:mana/update_hud


def add_mana(amount: int, update = True):
    scoreboard players add @s genesis.mana.current (amount)
    scoreboard players operation @s genesis.mana.current < @s genesis.mana.max
    if score @s genesis.mana.current = @s genesis.mana.max scoreboard players remove @s genesis.hud.display 1
    if update:
        function #genesis:mana/changed
        function genesis:mana/update_hud


def add_mana_by_score(name: str, objective: str, update = True):
    raw (f'scoreboard players operation @s genesis.mana.current += {name} {objective}')
    scoreboard players operation @s genesis.mana.current < @s genesis.mana.max
    if score @s genesis.mana.current = @s genesis.mana.max scoreboard players remove @s genesis.hud.display 1
    if update:
        function #genesis:mana/changed
        function genesis:mana/update_hud


append function genesis:load:
    scoreboard objectives add genesis.mana.current dummy
    scoreboard objectives add genesis.mana.max dummy
    scoreboard objectives add genesis.mana.filled_pixels dummy


append function_tag genesis:stat/update/mana_pool {"values":["genesis:mana/calculate_max_mana"]}
function ~/calculate_max_mana:
    scoreboard players set @s genesis.mana.max 20
    scoreboard players operation @s genesis.mana.max *= @s genesis.stat.mana_pool
    scoreboard players operation @s genesis.mana.current < @s genesis.mana.max
    unless score @s genesis.mana.current = @s genesis.mana.max scoreboard players add @s genesis.hud.display 1
    unless score @s genesis.mana.current = @s genesis.mana.max tag @s add genesis.hud.display
    function #genesis:mana/changed
    function genesis:mana/update_hud


predicate ~/is_full {
    "condition": "minecraft:entity_scores",
    "entity": "this",
    "scores": {
        "genesis.mana.current": {
            "min": {
                "type": "minecraft:score",
                "target": "this",
                "score": "genesis.mana.max"
            },
            "max": {
                "type": "minecraft:score",
                "target": "this",
                "score": "genesis.mana.max"
            }
        }
    }
}


append function genesis:tick:
    as @a[predicate=!genesis:mana/is_full] function genesis:mana/tick
function ~/tick:
    add_mana_by_score('@s', 'genesis.stat.mana_regen')


function ~/update_hud:
    function ~/../should_display:
        #> CALCULATE FILLED PIXEL AMOUNT
        # (cm * mp) / mm = filled pixel amount
        scoreboard players set #new genesis.mana.filled_pixels 79
        scoreboard players operation #new genesis.mana.filled_pixels *= @s genesis.mana.current
        scoreboard players operation #new genesis.mana.filled_pixels /= @s genesis.mana.max
        #> CHECK IF IS_DROWNING CHANGED
        if entity @s[tag=genesis.mana.is_drowning] at @s anchored eyes positioned ^ ^ ^ unless predicate genesis:mana/is_drowning if data entity @s {Air:300s} return run tag @s remove genesis.mana.is_drowning
        if entity @s[tag=!genesis.mana.is_drowning] at @s anchored eyes positioned ^ ^ ^ if predicate genesis:mana/is_drowning return run tag @s add genesis.mana.is_drowning

        execute if score #new genesis.mana.filled_pixels = @s genesis.mana.filled_pixels return 0
        return 1

    unless function ~/../should_display return 0
    scoreboard players operation @s genesis.mana.filled_pixels = #new genesis.mana.filled_pixels
    #> MODIFY PLAYER HUD STORAGE
    with PerPlayerStorage():
        execute function ~/../update_hud_wrapped:
            #> RETURN EARLY IF MANA IS FULL => HIDE HUD
            if score @s genesis.mana.current = @s genesis.mana.max return run data modify storage genesis:player self.hud[0] set value [""]
            if entity @s[tag=!genesis.mana.is_drowning] data modify storage genesis:player self.hud[0] set value [{
                text: "+",
                font: "genesis:hud/mana_bar",
                shadow_color: 0,
            }]
            if entity @s[tag=genesis.mana.is_drowning] data modify storage genesis:player self.hud[0] set value [{
                text: "+",
                font: "genesis:hud/mana_bar_drowning",
                shadow_color: 0,
            }]
            #> SET UP VALUES FOR PLACING THE NOTCHES CORRECTLY
            scoreboard players set #is_notch genesis 0
            scoreboard players set #next_notch genesis 79
            scoreboard players operation #next_notch genesis *= @s genesis.mana.max
            scoreboard players operation #next_notch genesis %= constant(39500) genesis
            #> GO THROUGH EACH PIXEL OF THE BAR AND ADD THE CORRECT KIND TO STORAGE
            for i in range(79):
                ri = 79 - i
                if score #new genesis.mana.filled_pixels matches (ri)                                                           data modify storage genesis:player self.hud[0] append value "l|"
                if score #new genesis.mana.filled_pixels matches (ri+1, None) if score #is_notch genesis <= #next_notch genesis data modify storage genesis:player self.hud[0] append value "r|"
                if score #new genesis.mana.filled_pixels matches (ri+1, None) if score #is_notch genesis >  #next_notch genesis data modify storage genesis:player self.hud[0] append value "n|"
                if score #new genesis.mana.filled_pixels matches (None, ri-1) if score #is_notch genesis <= #next_notch genesis data modify storage genesis:player self.hud[0] append value "R|"
                if score #new genesis.mana.filled_pixels matches (None, ri-1) if score #is_notch genesis >  #next_notch genesis data modify storage genesis:player self.hud[0] append value "N|"

                if score #is_notch genesis >= #next_notch genesis scoreboard players add #next_notch genesis 39500
                scoreboard players operation #is_notch genesis += @s genesis.mana.max
            data modify storage genesis:player self.hud[0] append value "Bb-"


predicate ~/is_drowning {
    "condition": "minecraft:location_check",
    "predicate": {"fluid": {"fluids": "#minecraft:water"}}
}
