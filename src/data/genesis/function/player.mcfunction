
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
    data modify storage genesis:player players append value {}
    # Set all initial stats
    scoreboard players set @s genesis.stat.mana_pool 100
    scoreboard players set @s genesis.stat.mana_regen 1
    # Call stat update function tags
    function #genesis:stat/update/mana_pool
    function #genesis:stat/update/mana_regen
    # Set current mana to maximum
    scoreboard players operation @s genesis.mana.current = @s genesis.mana.max
