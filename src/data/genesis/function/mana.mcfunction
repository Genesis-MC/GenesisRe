from genesis:player import PerPlayerStorage


append function genesis:load:
    scoreboard objectives add genesis.mana.current dummy
    scoreboard objectives add genesis.mana.max dummy


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
    with PerPlayerStorage():
        data modify storage genesis:player self.hud[0] set value [{text:"Manabar"}]
        #! TODO - actually implement the mana bar lol


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
