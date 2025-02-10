
advancement ~/join {
    "criteria": { "criteria": { "trigger": "minecraft:tick" }},
    "rewards": { "function": "genesis:first_join/join" },
}
function ~/join:
    # Set all initial stats
    scoreboard players set @s genesis.stat.mana_pool 100
    scoreboard players set @s genesis.stat.mana_regen 1
    # Call stat update function tags
    function #genesis:stat/update/mana_pool
    function #genesis:stat/update/mana_regen
    # Set current mana to maximum
    scoreboard players operation @s genesis.mana.current = @s genesis.mana.max
