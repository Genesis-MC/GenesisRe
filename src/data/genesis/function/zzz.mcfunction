#> THIS FILE IS FOR EVERYTHING ONLY USED FOR DEVELOPMENT THAT SHOULD NOT BE IN THE FINAL RELEASE

from genesis:status import GenesisStatus, on_apply_status, on_remove_status, before_value_change_status, after_value_change_status, synced_tick_status, scheduled_tick_status

append function genesis:load:
    say GENESIS:RE RELOADED
    
function ~/reset_player_join:
    # This will delete all player storage data, reassign all ids and reset all stats, the stats will most likely desync if you have stats from anything other than attributes
    scoreboard players reset * genesis.player.id
    data remove storage genesis:player players
    advancement revoke @s only genesis:player/join
    scoreboard players reset @s genesis.status.has_icon
    scoreboard players reset @s genesis.status.has_visual_cooldown
    scoreboard players reset @s genesis.hud.display
