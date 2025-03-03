from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, break_text_into_lines, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

# Steelhilt
@add_custom_recipe([
    ["iron_ingot", "iron_ingot", "iron_ingot"],
    ["iron_ingot", "stick", "iron_ingot"],
    ["iron_ingot", "iron_ingot", "iron_ingot"],
])

# Gildedhilt
@add_custom_recipe([
    ["gold_ingot", "gold_ingot", "gold_ingot"],
    ["gold_ingot", SteelHilt, "gold_ingot"],
    ["gold_ingot", "gold_ingot", "gold_ingot"],
])

# Bejeweledhilt
@add_custom_recipe([
    ["diamond", "diamond", "diamond"],
    ["diamond", GildedHilt, "diamond"],
    ["diamond", "diamond", "diamond"],
])

# CrimsonAlloy
@add_custom_recipe([
    [NetheriteSediment, ShardOfTheCrimsonAbyss, NetheriteSediment],
    [ShardOfTheCrimsonAbyss, MetalAlloy, ShardOfTheCrimsonAbyss],
    [NetheriteSediment, ShardOfTheCrimsonAbyss, NetheriteSediment],
])

# WarpedAlloy
@add_custom_recipe([
    [NetheriteSediment, ShardOfTheWarpedEmpyrean, NetheriteSediment],
    [ShardOfTheWarpedEmpyrean, MetalAlloy, ShardOfTheWarpedEmpyrean],
    [NetheriteSediment, ShardOfTheWarpedEmpyrean, NetheriteSediment],
])

# VerdantGem
@add_custom_recipe([
    [VerdantTwig, MossyBark, VerdantTwig],
    [MossyBark, "emerald", MossyBark],
    [VerdantTwig, MossyBark, VerdantTwig],
])

# VermillionGem
@add_custom_recipe([
    [VermillionClay, VermillionClay, VermillionClay],
    [VermillionClay, "diamond", VermillionClay],
    [VermillionClay, VermillionClay, VermillionClay],
])

# ShadedEnderPearl
@add_custom_recipe([
    ["air", ShadeFlux, "air"],
    [ShadeFlux, "ender_pearl", ShadeFlux],
    ["air", ShadeFlux, "air"],
])

# VoidedEnderPearl
@add_custom_recipe([
    ["air", VoidedFragment, "air"],
    [VoidedFragment, ShadedEnderPearl, VoidedFragment],
    ["air", VoidedFragment, "air"],
])

# PureCrystal
@add_custom_recipe([
    [PureCrystalDust, PureCrystalDust, PureCrystalDust],
    [PureCrystalDust, "amethyst_shard", PureCrystalDust],
    [PureCrystalDust, PureCrystalDust, PureCrystalDust],
])

# YellowEnhancementCrystal
@add_custom_recipe([
    [CrystalDust, CrystalDust, CrystalDust],
    [CrystalDust, "amethyst_shard", CrystalDust],
    [CrystalDust, CrystalDust, CrystalDust],
])

# PinkEnhancementCrystal
@add_custom_recipe([
    ["air", YellowEnhancementCrystal, "air"],
    [YellowEnhancementCrystal, "amethyst_shard", YellowEnhancementCrystal],
    ["air", YellowEnhancementCrystal, "air"],
])

# CrimsonEnhancementCrystal
@add_custom_recipe([
    ["air", PinkEnhancementCrystal, "air"],
    [PinkEnhancementCrystal, "amethyst_shard", PinkEnhancementCrystal],
    ["air", PinkEnhancementCrystal, "air"],
])

# CeruleanEnhancementCrystal
@add_custom_recipe([
    ["air", CrimsonEnhancementCrystal, "air"],
    [CrimsonEnhancementCrystal, "amethyst_shard", CrimsonEnhancementCrystal],
    ["air", CrimsonEnhancementCrystal, "air"],
])

@add_loot_table
@bolt_item
class ShadeFlux(GenesisItem):
    item_name = ("Shade Flux", {"color":"dark_purple"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "Mesmerizingly beautiful... and beautifully ominous",
        "item.genesis.shade_flux.lore",
        italic = True,
    )
    item_model = texture_path_to_item_model("genesis:item/ingredient/shade_flux")
