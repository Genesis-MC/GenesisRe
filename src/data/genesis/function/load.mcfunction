append function_tag minecraft:load { "values": [ "genesis:load" ] }

scoreboard objectives add genesis dummy

function genesis:tick
prepend function genesis:tick: # prepend so that order of compiling doesn't matter
    schedule function ~/ 1t
    store result score .gametime genesis time query gametime
