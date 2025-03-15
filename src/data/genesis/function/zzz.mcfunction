#> THIS FILE IS FOR EVERYTHING ONLY USED FOR DEVELOPMENT THAT SHOULD NOT BE IN THE FINAL RELEASE

from genesis:status import GenesisStatus, on_apply_status, on_remove_status, before_value_change_status, after_value_change_status, synced_tick_status, scheduled_tick_status


function ~/reset_player_join:
    # This will delete all player storage data, reassign all ids and reset all stats, the stats will most likely desync if you have stats from anything other than attributes
    scoreboard players reset * genesis.player.id
    data remove storage genesis:player players
    advancement revoke @s only genesis:player/join
    scoreboard players reset @s genesis.status.has_icon
    scoreboard players reset @s genesis.status.has_visual_cooldown
    scoreboard players reset @s genesis.hud.display


class FrederickTheStatus(GenesisStatus):
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


class UniqueStatus(GenesisStatus):
    category = ["buff","regeneration","bad"]
    icon = "genesis:font/status/poison_or_something"

    @on_remove_status
    def say_thjat_imr_removed(status):
        say (status.id + " has been removed")

    @before_value_change_status
    def valcahngeee(status):
        say (status.id + " will change")

    @after_value_change_status
    def valcahnge(status):
        say (status.id + " changed")

function ~/second_status_test:
    UniqueStatus.apply(240, 765)

function ~/increase_value_by_12:
    unless entity @s[tag=(UniqueStatus.tag)] return run say I DONT HAVE THIS STATUS, SILLY
    UniqueStatus.modify_value('+=', 12)


class ChestTwo(GenesisStatus):
    slot = "chest"
    permanent = True
    icon = "genesis:font/status/steadfast_cooldown"

function ~/chest_two_apply:
    ChestTwo.apply()


class NewStatus(GenesisStatus):
    icon = "genesis:font/status/poison_or_something"

    @synced_tick_status(20)
    def synced_status_thingy(cls):
        tellraw @a [
            "this_next:",
            {"score":{"name":"@s","objective":(cls.synced_tick)}},
            " - next_global:",
            {"score":{"name":"@s","objective":"genesis.status.synced_tick.next"}},
            " - gt:",
            {"score":{"name":".gametime","objective":"genesis"}},
        ]

    @scheduled_tick_status(20)
    def schjedule_ticks(cls):
        tellraw @a [
            "gt:",
            {"score":{"name":".gametime","objective":"genesis"}},
        ]


function ~/znew_status_apply:
    NewStatus.apply(15*20)
