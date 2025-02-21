#> THIS FILE IS FOR EVERYTHING ONLY USED FOR DEVELOPMENT THAT SHOULD NOT BE IN THE FINAL RELEASE

from genesis:status import genesis_status, on_apply_status, on_remove_status


function ~/reset_player_join:
    # This will delete all player storage data, reassign all ids and reset all stats, the stats will most likely desync if you have stats from anything other than attributes
    scoreboard players reset * genesis.player.id
    data remove storage genesis:player players
    advancement revoke @s only genesis:player/join


@genesis_status
class FrederickTheStatus:
    slot = "chest"
    category = ["bad","good","technical","slowing","stops_movement"]

    @on_apply_status
    def say_uwu(status):
        say ('uwu ' + status.id)

    @on_remove_status
    def say_buibui(status):
        say ('buibui ' + status.id)


function ~/test_apply_status:
    FrederickTheStatus.apply(200, 125)
