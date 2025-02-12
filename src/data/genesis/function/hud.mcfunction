
append function genesis:load:
    scoreboard objectives add genesis.hud.until dummy


append function genesis:tick:
    as @a[tag=!genesis.hud.display] if score @s genesis.hud.until >= .gametime genesis tag @s add genesis.hud.display
    as @a[tag=genesis.hud.display] function genesis:hud/tick


function ~/tick:
    unless score @s genesis.hud.until >= .gametime genesis return run function ~/../disable_hud:
        tag @s remove genesis.hud.display
        # Clear actionbar if hud should no longer be displayed to disable fading
        title @s actionbar ""
        # This is technically not needed if we mess with title times but they can only be set for all titles at once
        # Not doing this would safe 2 ticking @a tag checks

    # This is using a macro to support any amount of players, we could hardcode the first few players to reduce lag when playing with like up to 3 people
    # Not even sure how much it will help though, would save a macro call and a storage write and read at the cost of 3 more score checks
    #! Think if this should be done
    store result storage genesis:temp player.id int 1 scoreboard players get @s genesis.player.id
    execute function ~/../display_hud_macro with storage genesis:temp player:
        $title @s actionbar {nbt:"players[$(id)].hud",storage:"genesis:player",interpret:true}
