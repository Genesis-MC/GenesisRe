from genesis:player import PerPlayerStorage
from genesis:utils import constant


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
    function #genesis:mana/changed
    function genesis:mana/update_hud


append function genesis:tick:
    as @a unless score @s genesis.mana.current = @s genesis.mana.max function genesis:mana/tick
function ~/tick:
    scoreboard players operation @s genesis.mana.current += @s genesis.stat.mana_regen
    scoreboard players operation @s genesis.mana.current < @s genesis.mana.max
    if score @s genesis.mana.current = @s genesis.mana.max scoreboard players remove @s genesis.hud.display 1
    function #genesis:mana/changed
    function genesis:mana/update_hud


function ~/update_hud:
    #> CALCULATE IF RERENDER IS NECESSARY
    # (cm * mp) / mm = filled pixel amount
    scoreboard players set #new genesis.mana.filled_pixels 79
    scoreboard players operation #new genesis.mana.filled_pixels *= @s genesis.mana.current
    scoreboard players operation #new genesis.mana.filled_pixels /= @s genesis.mana.max
    execute if score #new genesis.mana.filled_pixels = @s genesis.mana.filled_pixels return 0
    scoreboard players operation @s genesis.mana.filled_pixels = #new genesis.mana.filled_pixels
    #> MODIFY PLAYER HUD STORAGE
    with PerPlayerStorage():
        execute function ~/../update_hud_wrapped:
            #> RETURN EARLY IF MANA IS FULL => HIDE HUD
            if score @s genesis.mana.current = @s genesis.mana.max return run data modify storage genesis:player self.hud[0] set value [""]
            data modify storage genesis:player self.hud[0] set value [{
                text: "+",
                font: "genesis:hud/mana_bar",
                shadow_color: 0,
            }]
            #> SET UP VALUES FOR PLACING THE NOTCHES CORRECTLY
            scoreboard players set #is_notch genesis 79
            scoreboard players operation #is_notch genesis *= @s genesis.mana.max
            scoreboard players set #next_notch genesis 79
            scoreboard players operation #next_notch genesis *= @s genesis.mana.max
            scoreboard players remove #next_notch genesis 39500
            #> GO THROUGH EACH PIXEL OF THE BAR AND ADD THE CORRECT KIND TO STORAGE
            for i in range(79):
                ri = 79 - i
                if score @s genesis.mana.filled_pixels matches (ri)                                                           data modify storage genesis:player self.hud[0] append value {text:"l|"}
                if score @s genesis.mana.filled_pixels matches (ri+1, None) if score #is_notch genesis >  #next_notch genesis data modify storage genesis:player self.hud[0] append value {text:"r|"}
                if score @s genesis.mana.filled_pixels matches (ri+1, None) if score #is_notch genesis <= #next_notch genesis data modify storage genesis:player self.hud[0] append value {text:"n|"}
                if score @s genesis.mana.filled_pixels matches (None, ri-1) if score #is_notch genesis >  #next_notch genesis data modify storage genesis:player self.hud[0] append value {text:"R|"}
                if score @s genesis.mana.filled_pixels matches (None, ri-1) if score #is_notch genesis <= #next_notch genesis data modify storage genesis:player self.hud[0] append value {text:"N|"}

                if score #is_notch genesis <= #next_notch genesis scoreboard players remove #next_notch genesis 39500
                scoreboard players operation #is_notch genesis -= @s genesis.mana.max
            data modify storage genesis:player self.hud[0] append value {text:"Bb-"}


def reduce_mana_or_return(amount: int, update = True): # This is actual mana, so 20x higher than the mana_pool stat and the mana communicated to the player
    if score @s genesis.mana.current matches (None, amount - 1) return 0
    if score @s genesis.mana.current = @s genesis.mana.max scoreboard players add @s genesis.hud.display 1
    scoreboard players remove @s genesis.mana.current (amount)
    if update:
        function #genesis:mana/changed
        function genesis:mana/update_hud


def reduce_mana_by_score_or_return(name: str, objective: str, update = True): # This is actual mana, so 20x higher than the mana_pool stat and the mana communicated to the player
    raw (f'execute if score {name} {objective} > @s genesis.mana.current run return 0')
    if score @s genesis.mana.current = @s genesis.mana.max scoreboard players add @s genesis.hud.display 1
    raw (f'scoreboard players operation @s genesis.mana.current -= {name} {objective}')
    if update:
        function #genesis:mana/changed
        function genesis:mana/update_hud
