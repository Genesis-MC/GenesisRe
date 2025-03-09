from genesis:player import PerPlayerStorage
from genesis:utils import constant, smart_scoreboard_operation


def reduce_mana_or_return(amount: int|tuple[str,str], update = True): # This is actual mana, so 200x higher than the mana_pool stat and the mana communicated to the player
    if isinstance(amount, int):
        if score @s genesis.mana.current matches (None, amount - 1) return 0
    else:
        raw (f'execute if score {name} {objective} > @s genesis.mana.current run return 0')

    if score @s genesis.mana.current = @s genesis.mana.max scoreboard players add @s genesis.hud.display 1

    smart_scoreboard_operation('@s','genesis.mana.current','-=',amount)

    if score @s genesis.mana.current matches 0 scoreboard players remove @s genesis.hud.display 1
    if update:
        function #genesis:mana/changed
        function genesis:mana/update_hud


def add_mana(amount: int|tuple[str,str], update = True): # This is actual mana, so 200x higher than the mana_pool stat and the mana communicated to the player
    if score @s genesis.mana.current matches 0 scoreboard players add @s genesis.hud.display 1

    smart_scoreboard_operation('@s','genesis.mana.current','+=',amount)
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
    scoreboard players set @s genesis.mana.max 200
    scoreboard players operation @s genesis.mana.max *= @s genesis.stat.mana_pool
    scoreboard players operation @s genesis.mana.current < @s genesis.mana.max
    unless score @s genesis.mana.current = @s genesis.mana.max scoreboard players add @s genesis.hud.display 1
    function #genesis:mana/changed
    function genesis:mana/update_hud


predicate ~/should_regen {
    "condition": "minecraft:any_of",
    "terms": [
        {
            "condition": "minecraft:all_of",
            "terms": [
                {
                    "condition": "minecraft:inverted",
                    "term": {
                        "condition": "minecraft:entity_scores",
                        "entity": "this",
                        "scores": {
                            "genesis.mana.current": {
                                "min": {
                                    "type": "minecraft:score",
                                    "target": "this",
                                    "score": "genesis.mana.max"
                                }
                            }
                        }
                    }
                },
                {
                    "condition": "minecraft:entity_scores",
                    "entity": "this",
                    "scores": {
                        "genesis.stat.mana_regen": {
                            "min": 1
                        }
                    }
                }
            ]
        },
        {
            "condition": "minecraft:all_of",
            "terms": [
                {
                    "condition": "minecraft:entity_scores",
                    "entity": "this",
                    "scores": {
                        "genesis.mana.current": {
                            "min": 1
                        }
                    }
                },
                {
                    "condition": "minecraft:entity_scores",
                    "entity": "this",
                    "scores": {
                        "genesis.stat.mana_regen": {
                            "max": -1
                        }
                    }
                }
            ]
        }
    ]
}


append function genesis:player/tick:
    if predicate genesis:mana/should_regen function genesis:mana/tick
function ~/tick:
    if score @s genesis.mana.current matches 0 scoreboard players add @s genesis.hud.display 1
    if score @s genesis.mana.current = @s genesis.mana.max scoreboard players add @s genesis.hud.display 1

    scoreboard players operation @s genesis.mana.current += @s genesis.stat.mana_regen
    scoreboard players operation @s genesis.mana.current < @s genesis.mana.max
    if score @s genesis.mana.current matches ..-1 scoreboard players set @s genesis.mana.current 0

    if score @s genesis.mana.current matches 0 scoreboard players remove @s genesis.hud.display 1
    if score @s genesis.mana.current = @s genesis.mana.max scoreboard players remove @s genesis.hud.display 1
    function #genesis:mana/changed
    function genesis:mana/update_hud


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
            #> RETURN EARLY IF MANA IS FULL OR EMPTY => HIDE HUD
            unless score @s genesis.mana.filled_pixels matches 1..78 return run data modify storage genesis:player self.hud[0] set value [""]
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
            scoreboard players operation #next_notch genesis %= constant(395000) genesis
            #> GO THROUGH EACH PIXEL OF THE BAR AND ADD THE CORRECT KIND TO STORAGE
            for i in range(79):
                ri = 79 - i
                if score #new genesis.mana.filled_pixels matches (ri)                                                           data modify storage genesis:player self.hud[0] append value "l|"
                if score #new genesis.mana.filled_pixels matches (ri+1, None) if score #is_notch genesis <= #next_notch genesis data modify storage genesis:player self.hud[0] append value "r|"
                if score #new genesis.mana.filled_pixels matches (ri+1, None) if score #is_notch genesis >  #next_notch genesis data modify storage genesis:player self.hud[0] append value "n|"
                if score #new genesis.mana.filled_pixels matches (None, ri-1) if score #is_notch genesis <= #next_notch genesis data modify storage genesis:player self.hud[0] append value "R|"
                if score #new genesis.mana.filled_pixels matches (None, ri-1) if score #is_notch genesis >  #next_notch genesis data modify storage genesis:player self.hud[0] append value "N|"

                if score #is_notch genesis >= #next_notch genesis scoreboard players add #next_notch genesis 395000
                scoreboard players operation #is_notch genesis += @s genesis.mana.max
            data modify storage genesis:player self.hud[0] append value "Bb-"


predicate ~/is_drowning {
    "condition": "minecraft:location_check",
    "predicate": {"fluid": {"fluids": "#minecraft:water"}}
}
