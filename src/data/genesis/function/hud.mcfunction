import genesis:status/hud as shud # This ensures that the cooldown gets calculated before the hud is displayed

append function genesis:load:
    # This score is increased by 1 every time anything activates the hud and that same thing should reduce it by 1 if it is removed
    # That way this values represents the amount of things displayed on the hud and the hud can safely be removed if this is 0
    scoreboard objectives add genesis.hud.display dummy


append function genesis:tick:
    as @a[scores={genesis.hud.display=0..}] function genesis:hud/tick


function ~/tick:
    # This is using a macro to support any amount of players, we could hardcode the first few players to reduce lag when playing with like up to 3 people
    # Not even sure how much it will help though, would save a macro call and a storage write and read at the cost of 3 more score checks
    #! Think if this should be done
    store result storage genesis:temp player.id int 1 scoreboard players get @s genesis.player.id
    execute function ~/../display_hud_macro with storage genesis:temp player:
        $title @s actionbar {nbt:"players[$(id)].hud",storage:"genesis:player",interpret:true}
    # We do this after and don't return so that it gets displayed the tick after everything has been removed
    unless score @s genesis.hud.display matches 1.. scoreboard players reset @s genesis.hud.display
