from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

# SaberCrimson
@add_custom_recipe([
    ["air", "air", CrimsonAlloy],
    ["air", CrimsonAlloy, "air"],
    [BejeweledHilt, "air", "air"],
])

# SaberWarped
@add_custom_recipe([
    ["air", "air", WarpedAlloy],
    ["air", WarpedAlloy, "air"],
    [BejeweledHilt, "air", "air"],
])