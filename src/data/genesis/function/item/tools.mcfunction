from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

# CrystalLens
@add_custom_recipe([
    ["air", "glass_pane", "air"],
    ["glass_pane", CrystalDust, "glass_pane"],
    [SteelHilt, "glass_pane", "air"],
])

# PrismaticPickaxe
@add_custom_recipe([
    [PureCrystal, PureCrystal, PureCrystal],
    ["air", BejeweledHilt, "air"],
    ["air", BejeweledHilt, "air"],
])

# NoviceMallet
@add_custom_recipe([
    ["air", "copper_block", "copper_ingot"],
    ["air", "stick", "copper_block"],
    ["stick", "air", "air"],
])

# ApprenticeMallet
@add_custom_recipe([
    ["iron_ingot", Inecraft:amethystShard",tag:{gen:{type:["uncommon"],mineral:1, "iron_ingot"],
    [Inecraft:amethystShard",tag:{gen:{type:["uncommon"],mineral:1, NovicesMallet, Inecraft:amethystShard",tag:{gen:{type:["uncommon"],mineral:1],
    ["iron_ingot", Inecraft:amethystShard",tag:{gen:{type:["uncommon"],mineral:1, "iron_ingot"],
])

# JourneymanMallet
@add_custom_recipe([
    ["gold_ingot", Inecraft:amethystShard",tag:{gen:{type:["rare"],mineral:1, "gold_ingot"],
    [Inecraft:amethystShard",tag:{gen:{type:["rare"],mineral:1, ApprenticesMallet, Inecraft:amethystShard",tag:{gen:{type:["rare"],mineral:1],
    ["gold_ingot", Inecraft:amethystShard",tag:{gen:{type:["rare"],mineral:1, "gold_ingot"],
])

# ExpertMallet
@add_custom_recipe([
    ["diamond", Inecraft:amethystShard",tag:{gen:{type:["epic"],mineral:1, "diamond"],
    [Inecraft:amethystShard",tag:{gen:{type:["epic"],mineral:1, JourneymansMallet, Inecraft:amethystShard",tag:{gen:{type:["epic"],mineral:1],
    ["diamond", Inecraft:amethystShard",tag:{gen:{type:["epic"],mineral:1, "diamond"],
])

# MasterMallet
@add_custom_recipe([
    ["netherite_ingot", Inecraft:amethystShard",tag:{gen:{type:["legendary"],mineral:1, "netherite_ingot"],
    [Inecraft:amethystShard",tag:{gen:{type:["legendary"],mineral:1, ExpertsMallet, Inecraft:amethystShard",tag:{gen:{type:["legendary"],mineral:1],
    ["netherite_ingot", Inecraft:amethystShard",tag:{gen:{type:["legendary"],mineral:1, "netherite_ingot"],
])

