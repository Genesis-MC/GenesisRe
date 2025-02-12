#> THIS FILE IS FOR EVERYTHING ONLY USED FOR DEVELOPMENT THAT SHOULD NOT BE IN THE FINAL RELEASE


function ~/reset_player_join:
    # This will delete all player storage data, reassign all ids and reset all stats, the stats will most likely desync if you have stats from anything other than attributes
    scoreboard players reset * genesis.player.id
    data remove storage genesis:player players
    advancement revoke @s only genesis:player/join
