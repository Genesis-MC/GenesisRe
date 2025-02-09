import genesis:genesis_items as genesis_items
from genesis:mapping import item_display_uuid

append function_tag minecraft:load { "values": [ "genesis:load" ] }

scoreboard objectives add genesis dummy
unless entity item_display_uuid["hex"] run summon item_display ~ -500 ~ {Tags: ["genesis.permanent_item_display"], UUID: item_display_uuid["array"]}

function genesis:tick
prepend function genesis:tick: # prepend so that order of compiling doesn't matter
    schedule function ~/ 1t
