from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

# IronSpear
@add_custom_recipe([
    ["iron_ingot", "iron_ingot", "air"],
    ["iron_ingot", "stick", "air"],
    ["air", "air", "stick"],
])
# IronSpear
@add_custom_recipe([
    ["air", "iron_ingot", "iron_ingot"],
    ["air", "stick", "iron_ingot"],
    ["stick", "air", "air"],
])

#! CHECK RECIPE 
# Glaive
@add_custom_recipe([
    [MetalAlloy, MetalAlloy, "air"],
    [MetalAlloy, "stick", "air"],
    ["air", "air", SteelHilt],
])
# Glaive
@add_custom_recipe([
    ["air", MetalAlloy, MetalAlloy],
    ["air", "stick", MetalAlloy],
    [SteelHilt, "air", "air"],
])

# Halycon
@add_custom_recipe([
    ["air", CrystalScale, "diamond_block"],
    [CrystalScale, SteelHilt, CrystalScale],
    [SteelHilt, CrystalScale, "air"],
])

# HeavensThorn
@add_custom_recipe([
    ["air", "gold_block", "air"],
    [HelixSpear, "quartz", HelixSpear],
    ["air", GildedHilt, "air"],
])

# VerdantStaff
@add_custom_recipe([
    ["air", "air", VerdantGem],
    ["air", VerdantTwig, "air"],
    [VerdantTwig, "air", "air"],
])

# VerdantMasterstaff
@add_custom_recipe([
    [VerdantShard, VerdantShard, VerdantShard],
    [VerdantShard, VerdantStaff, VerdantShard],
    [VerdantShard, VerdantShard, VerdantShard],
])

# VerdantSceptor
@add_custom_recipe([
    [CrystalScale, VerdantGem, CrystalScale],
    [VerdantGem, VerdantMasterstaff, VerdantGem],
    [CrystalScale, VerdantGem, CrystalScale],
])