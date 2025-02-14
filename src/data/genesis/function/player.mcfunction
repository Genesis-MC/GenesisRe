
append function genesis:load:
    scoreboard objectives add genesis.player.id dummy


advancement ~/join {
    "criteria": { "criteria": { "trigger": "minecraft:tick" }},
    "rewards": { "function": "genesis:player/join" },
}


function ~/join:
    # Give player a unique id, this starts counting from 0
    scoreboard players operation @s genesis.player.id = .next_id genesis.player.id
    scoreboard players add .next_id genesis.player.id 1
    # Initialize player based storage, this can be accessed using `storage genesis:player players[$(id)]`
    data modify storage genesis:player players append value {
        # hud is used for the hud, each array entry is for one module
        # mana, status
        hud:[[""],[""]],
    }
    # Set all initial stats
    scoreboard players set @s genesis.stat.mana_pool 100
    scoreboard players set @s genesis.stat.mana_regen 1
    # Call stat update function tags
    function #genesis:stat/update/mana_pool
    function #genesis:stat/update/mana_regen
    # Set current mana to maximum
    scoreboard players operation @s genesis.mana.current = @s genesis.mana.max


function ~/storage/get_self_macro:
    $data modify storage genesis:player self set from storage genesis:player players[$(id)]
function ~/storage/save_self_macro:
    $data modify storage genesis:player players[$(id)] set from storage genesis:player self


class PerPlayerStorage():
    def __enter__(self):
        store result storage genesis:temp player.id int 1 scoreboard players get @s genesis.player.id
        function genesis:player/storage/get_self_macro with storage genesis:temp player

    def __exit__(self, *args):
        function genesis:player/storage/save_self_macro with storage genesis:temp player
