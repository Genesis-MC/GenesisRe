from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

# IronScythe
@add_custom_recipe([
    ["air", "iron_ingot", "iron_ingot"],
    ["iron_ingot", "air", "stick"],
    ["air", "air", "stick"],
])
# IronScythe
@add_custom_recipe([
    ["iron_ingot", "iron_ingot", "air"],
    ["stick", "air", "iron_ingot"],
    ["stick", "air", "air"],
])

# VenomlashFang
@add_custom_recipe([
    [VenomSac, "diamond", VenomSac],
    ["diamond", RecluseFang, "diamond"],
    [VenomSac, "diamond", VenomSac],
])