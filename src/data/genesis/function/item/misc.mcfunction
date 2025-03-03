from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, break_text_into_lines, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

# EnhancedManaCookie
@add_custom_recipe([
    ["air", ManaBean, "air"],
    [ManaBean, ManaCookie, ManaBean],
    ["air", ManaBean, "air"],
])

# AuricManaCookie
@add_custom_recipe([
    ["air", ManaBean, "air"],
    [ManaBean, EnhancedManaCookie, ManaBean],
    ["air", ManaBean, "air"],
])

# CrystalNode
@add_custom_recipe([
    ["amethyst_shard", "glass", "amethyst_shard"],
    ["glass", CrystalBuds, "glass"],
    ["amethyst_shard", "glass", "amethyst_shard"],
])

# PiratesBounty
@add_custom_recipe([
    [AncientGoldCoin, AncientGoldCoin, AncientGoldCoin],
    [AncientGoldCoin, "chest", AncientGoldCoin],
    [AncientGoldCoin, AncientGoldCoin, AncientGoldCoin],
])

# HeartOfTheDepths
@add_custom_recipe([
    [ShardOfTheDepths, ShardOfTheDepths, ShardOfTheDepths],
    [ShardOfTheDepths, "chest", ShardOfTheDepths],
    [ShardOfTheDepths, ShardOfTheDepths, ShardOfTheDepths],
])