from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem


# HunterVest
#@add_custom_recipe([
#    [Tag:["#minecraft:woo, Tag:["#minecraft:woo, Tag:["#minecraft:woo],
#    [Tag:["#minecraft:woo, "leather_chestplate", Tag:["#minecraft:woo],
#    [Tag:["#minecraft:woo, Tag:["#minecraft:woo, Tag:["#minecraft:woo],
#])

# RangerVest
@add_custom_recipe([
    [BoarHide, BoarHide, BoarHide],
    [BoarHide, HunterVest, BoarHide],
    [BoarHide, BoarHide, BoarHide],
])

# PlainstreaderBoots
@add_custom_recipe([
    ["short_grass", "short_grass", "short_grass"],
    ["short_grass", "leather_boots", "short_grass"],
    ["short_grass", "short_grass", "short_grass"],
])

# ForesttreaderBoots
@add_custom_recipe([
    [VerdantTwig, VerdantTwig, VerdantTwig],
    [VerdantTwig, PlainstreaderBoots, VerdantTwig],
    [VerdantTwig, VerdantTwig, VerdantTwig],
])

# MountaintreaderBoots
@add_custom_recipe([
    [BlizzardTear, BlizzardTear, BlizzardTear],
    [BlizzardTear, ForesttreaderBoots, BlizzardTear],
    [BlizzardTear, BlizzardTear, BlizzardTear],
])

# PhantomtreaderBoots
@add_custom_recipe([
    [VoidedFragment, VoidedFragment, VoidedFragment],
    [VoidedFragment, MountaintreaderBoots, VoidedFragment],
    [VoidedFragment, VoidedFragment, VoidedFragment],
])

# CloudtreaderBoots
@add_custom_recipe([
    [CrystalScale, CrystalScale, CrystalScale],
    [CrystalScale, PhantomtreaderBoots, CrystalScale],
    [CrystalScale, CrystalScale, CrystalScale],
])

# TerratreaderBoots
@add_custom_recipe([
    [TerraclodPearl, TerraclodPearl, TerraclodPearl],
    [TerraclodPearl, CloudtreaderBoots, TerraclodPearl],
    [TerraclodPearl, TerraclodPearl, TerraclodPearl],
])

# HelmetOfTheLancerKnight
@add_custom_recipe([
    ["air", MetalAlloy, "air"],
    ["gold_ingot", PriarieGuardsHelmet, "gold_ingot"],
    ["air", MetalAlloy, "air"],
])

# WitchsRobe
@add_custom_recipe([
    [Cloth, "air", Cloth],
    [Cloth, "black_dye", Cloth],
    [Cloth, ArcaneCloth, Cloth],
])

# CrystalCirclet
@add_custom_recipe([
    ["air", VerdantGem, "air"],
    [CrystalScale, "diamond_helmet", CrystalScale],
    ["air", CrystalScale, "air"],
])

# GhastlyChestplate
@add_custom_recipe([
    ["ghast_tear", "air", "ghast_tear"],
    ["ghast_tear", MetalAlloy, "ghast_tear"],
    ["ghast_tear", "ghast_tear", "ghast_tear"],
])

# EtherealChestplate
@add_custom_recipe([
    ["air", ShadedEnderPearl, "air"],
    [ShardOfTheWarpedEmpyrean, GhastlyChestplate, ShardOfTheWarpedEmpyrean],
    ["air", ShadedEnderPearl, "air"],
])
@add_loot_table
@bolt_item
class EtherealChestplate(GenesisItem):
    item_name = ("Ethereal Chestplate", {"color":"dark_aqua"})
    item_model = "diamond_chestplate" #! use custom texture instead
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"} #! use custom texture instead
    stats = ("chest", {"armor":80,"armor_toughness":10})
    category = ["chestplate"]
    rarity = "epic"
    passives = [{
        "name": "Steadfast",
        "description": "Every 12 seconds, after taking damage, gain +100 Knockback Resistance for 5 seconds.",
    }]

    @on_attacked(full_slot = 'armor.chest')
    def gain_knockback_resistance():
        say NOT IMPLEMENTED YET #! can be added when passive cooldown is a thing