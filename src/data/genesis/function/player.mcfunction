
append function genesis:load:
    scoreboard objectives add genesis.player.id dummy
    # Add scoreboards for passives and abilities
    scoreboard objectives add genesis.passive.arcane_edge_statboost dummy
    scoreboard objectives add genesis.ability.void_cage_duration dummy


append function genesis:tick:
    as @a at @s function genesis:player/tick


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
        hud: [
            [""], # Mana bar
            [""], # Status icons
            [""], # Status cooldown
        ],
    }
    # Set all initial stats
    scoreboard players set @s genesis.stat.mana_pool 100
    scoreboard players set @s genesis.stat.mana_regen 50
    # Call stat update function tags
    function #genesis:stat/update/mana_pool
    function #genesis:stat/update/mana_regen
    # Set current mana to maximum
    scoreboard players operation @s genesis.mana.current = @s genesis.mana.max
    function genesis:mana/update_hud
    tag @s add genesis.player


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
