from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, BlizzardTear, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, HexedHailstone, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 
        
#! add passives

# HunterVest
@add_custom_recipe([
    ["#wool", "#wool", "#wool"],
    ["#wool", "leather_chestplate", "#wool"],
    ["#wool", "#wool", "#wool"],
])
@add_loot_table
@bolt_item
class HuntersVest(GenesisItem):
    item_name = ("Hunter's Vest", {"color":"white"})
    rarity = "common"
    category = ["chestplate"]
    stats = ("chest", {"armor":50,"speed":10})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# RangerVest
@add_custom_recipe([
    [BoarHide, BoarHide, BoarHide],
    [BoarHide, HuntersVest, BoarHide],
    [BoarHide, BoarHide, BoarHide],
])
@add_loot_table
@bolt_item
class RangersVest(GenesisItem):
    item_name = ("Rangers Vest", {"color":"white"})
    rarity = "uncommon"
    category = ["chestplate"]
    stats = ("chest", {"armor":60,"speed":15})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# PlainstreaderBoots
@add_custom_recipe([
    ["short_grass", "short_grass", "short_grass"],
    ["short_grass", "leather_boots", "short_grass"],
    ["short_grass", "short_grass", "short_grass"],
])
@add_loot_table
@bolt_item
class PlainstreaderBoots(GenesisItem):
    item_name = ("Plainstreader Boots", {"color":"white"})
    rarity = "common"
    category = ["boots"]
    stats = ("feet", {"armor":5,"speed":5})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}

# ForesttreaderBoots
@add_custom_recipe([
    [VerdantTwig, VerdantTwig, VerdantTwig],
    [VerdantTwig, PlainstreaderBoots, VerdantTwig],
    [VerdantTwig, VerdantTwig, VerdantTwig],
])
@add_loot_table
@bolt_item
class ForesttreaderBoots(GenesisItem):
    item_name = ("Foresttreader Boots", {"color":"green"})
    rarity = "uncommon"
    category = ["boots"]
    stats = ("feet", {"armor":10,"speed":30})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}

# MountaintreaderBoots
@add_custom_recipe([
    [BlizzardTear, BlizzardTear, BlizzardTear],
    [BlizzardTear, ForesttreaderBoots, BlizzardTear],
    [BlizzardTear, BlizzardTear, BlizzardTear],
])
@add_loot_table
@bolt_item
class MountaintreaderBoots(GenesisItem):
    item_name = ("Mountaintreader Boots", {"color":"gray"})
    rarity = "rare"
    category = ["boots"]
    stats = ("feet", {"armor":15,"speed":90})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}

# PhantomtreaderBoots
@add_custom_recipe([
    [VoidedFragment, VoidedFragment, VoidedFragment],
    [VoidedFragment, MountaintreaderBoots, VoidedFragment],
    [VoidedFragment, VoidedFragment, VoidedFragment],
])
@add_loot_table
@bolt_item
class PhantomtreaderBoots(GenesisItem):
    item_name = ("Phantomtreader Boots", {"color":"dark_purple"})
    rarity = "epic"
    category = ["boots"]
    stats = ("feet", {"armor":20,"speed":150})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}

# CloudtreaderBoots
@add_custom_recipe([
    [CrystalScale, CrystalScale, CrystalScale],
    [CrystalScale, PhantomtreaderBoots, CrystalScale],
    [CrystalScale, CrystalScale, CrystalScale],
])
@add_loot_table
@bolt_item
class CloudtreaderBoots(GenesisItem):
    item_name = ("Cloudtreader Boots", {"color":"white"})
    rarity = "legendary"
    category = ["boots"]
    stats = ("feet", {"armor":25,"speed":200})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}

# TerratreaderBoots
@add_custom_recipe([
    [TerraclodPearl, TerraclodPearl, TerraclodPearl],
    [TerraclodPearl, CloudtreaderBoots, TerraclodPearl],
    [TerraclodPearl, TerraclodPearl, TerraclodPearl],
])
@add_loot_table
@bolt_item
class TerratreaderBoots(GenesisItem):
    item_name = ("Terratreader Boots", {"color":"gold"})
    rarity = "mythical"
    category = ["boots"]
    stats = ("feet", {"armor":25,"speed":250})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}

# PriarieGuardsHelmet
@add_loot_table
@bolt_item
class PriarieGuardsHelmet(GenesisItem):
    item_name = ("Priarie Guards Helmet", {"color":"white"})
    rarity = "uncommon"
    category = ["helmet"]
    stats = ("head", {"armor_toughness":35})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}
    
# HelmetOfTheLancerKnight
@add_custom_recipe([
    [None, MetalAlloy, None],
    ["gold_ingot", PriarieGuardsHelmet, "gold_ingot"],
    [None, MetalAlloy, None],
])
@add_loot_table
@bolt_item
class HelmetOfTheLancerKnight(GenesisItem):
    item_name = ("Helmet Of The Lancer Knight", {"color":"white"})
    rarity = "rare"
    category = ["helmet"]
    stats = ("head", {"armor_toughness":70})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# WitchsRobe
@add_custom_recipe([
    [Cloth, None, Cloth],
    [Cloth, "black_dye", Cloth],
    [Cloth, ArcaneCloth, Cloth],
])
@add_loot_table
@bolt_item
class WitchsRobe(GenesisItem):
    item_name = ("Witch's Robe", {"color":"dark_purple"})
    rarity = "rare"
    category = ["chestplate"]
    stats = ("chest", {"physical_power":-20,"armor":40,"mana_pool":20,"mana_regen":10})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# CrystalCirclet
@add_custom_recipe([
    [None, VerdantGem, None],
    [CrystalScale, "diamond_helmet", CrystalScale],
    [None, CrystalScale, None],
])
@add_loot_table
@bolt_item
class CrystalCirclet(GenesisItem):
    item_name = ("Crystal Circlet", {"color":"aqua"})
    rarity = "epic"
    category = ["helmet"]
    stats = ("head", {"magic_power":25,"attack_speed":10,"armor":30,"armor_toughness":10})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# GhastlyChestplate
@add_custom_recipe([
    ["ghast_tear", None, "ghast_tear"],
    ["ghast_tear", MetalAlloy, "ghast_tear"],
    ["ghast_tear", "ghast_tear", "ghast_tear"],
])
@add_loot_table
@bolt_item
class GhastlyChestplate(GenesisItem):
    item_name = ("Ghastly Chestplate", {"color":"white"})
    rarity = "rare"
    category = ["chestplate"]
    stats = ("chest", {"armor":65})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# EtherealChestplate
@add_custom_recipe([
    [None, ShadedEnderPearl, None],
    [ShardOfTheWarpedEmpyrean, GhastlyChestplate, ShardOfTheWarpedEmpyrean],
    [None, ShadedEnderPearl, None],
])
@add_loot_table
@bolt_item
class EtherealChestplate(GenesisItem):
    item_name = ("Ethereal Chestplate", {"color":"dark_aqua"})
    rarity = "epic"
    category = ["chestplate"]
    stats = ("chest", {"armor":80,"armor_toughness":10})
    item_model = "diamond_chestplate"
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}
    passives = [{
        "name": "Steadfast",
        "description": "Every 12 seconds, after taking damage, gain +100 Knockback Resistance for 5 seconds.",
    }]

    @on_attacked(full_slot = 'armor.chest')
    def gain_knockback_resistance():
        say NOT IMPLEMENTED YET #! can be added when passive cooldown is a thing

# BlackMarketBoots
@add_loot_table
@bolt_item
class BlackMarketBoots(GenesisItem):
    item_name = ("Black Market Boots", {"color":"white"})
    rarity = "uncommon"
    category = ["boots"]
    stats = ("feet", {"armor":5,"speed":-50,"luck":10})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}

# NomadicShawl
@add_loot_table
@bolt_item
class NomadicShawl(GenesisItem):
    item_name = ("Nomadic Shawl", {"color":"white"})
    rarity = "common"
    category = ["chestplate"]
    stats = ("chest", {"armor":30,"armor_toughness":-10,"speed":25})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# PatchedTrousers
@add_loot_table
@bolt_item
class PatchedTrousers(GenesisItem):
    item_name = ("Patched Trousers", {"color":"white"})
    rarity = "common"
    category = ["leggings"]
    stats = ("legs", {"armor":30})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# IgneousHelmet
@add_loot_table
@bolt_item
class IgneousHelmet(GenesisItem):
    item_name = ("Igneous Helmet", {"color":"gray"})
    rarity = "rare"
    category = ["helmet"]
    stats = ("head", {"armor":40,"armor_toughness":20,"knockback_resistance":20,"speed":-20})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# Heartguard
@add_loot_table
@bolt_item
class Heartguard(GenesisItem):
    item_name = ("Heartguard", {"color":"red"})
    rarity = "epic"
    category = ["chestplate"]
    stats = ("chest", {"health":200})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# BlueSpaceHelmet
@add_loot_table
@bolt_item
class BlueSpacehelmet(GenesisItem):
    item_name = ("Blue Spacehelmet", {"color":"blue"})
    rarity = "rare"
    category = ["helmet"]
    stats = ("head", {"armor":30,"armor_toughness":10})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# GreenSpaceHelmet
@add_loot_table
@bolt_item
class GreenSpacehelmet(GenesisItem):
    item_name = ("Green Spacehelmet", {"color":"green"})
    rarity = "rare"
    category = ["helmet"]
    stats = ("head", {"armor":30,"armor_toughness":10})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# PinkSpaceHelmet
@add_loot_table
@bolt_item
class PinkSpacehelmet(GenesisItem):
    item_name = ("Pink Spacehelmet", {"color":"light_purple"})
    rarity = "rare"
    category = ["helmet"]
    stats = ("head", {"armor":30,"armor_toughness":10})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# RedSpaceHelmet
@add_loot_table
@bolt_item
class RedSpacehelmet(GenesisItem):
    item_name = ("Red Spacehelmet", {"color":"red"})
    rarity = "rare"
    category = ["helmet"]
    stats = ("head", {"armor":30,"armor_toughness":10})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# YellowSpaceHelmet
@add_loot_table
@bolt_item
class YellowSpacehelmet(GenesisItem):
    item_name = ("Yellow Spacehelmet", {"color":"yellow"})
    rarity = "rare"
    category = ["helmet"]
    stats = ("head", {"armor":30,"armor_toughness":10})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# TreantTrousers
@add_loot_table
@bolt_item
class TreantTrousers(GenesisItem):
    item_name = ("Treant Trousers", {"color":"green"})
    rarity = "rare"
    category = ["leggings"]
    stats = ("legs", {"attack_speed":-8,"armor":50,"armor_toughness":10,"knockback_resistance":15})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# PerfectStrategy
@add_loot_table
@bolt_item
class PerfectStrategy(GenesisItem):
    item_name = ("Perfect Strategy", {"color":"white"})
    rarity = "epic"
    category = ["chestplate"]
    stats = ("chest", {"health":200,"armor":-500})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# Dunestride
@add_loot_table
@bolt_item
class Dunestride(GenesisItem):
    item_name = ("Dunestride", {"color":"gold"})
    rarity = "rare"
    category = ["elemental","leggings"]
    stats = ("legs", {"magic_power":20,"armor":50,"armor_toughness":20,"mana_pool":30})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# Atmosphere
@add_loot_table
@bolt_item
class Atmosphere(GenesisItem):
    item_name = ("Atmosphere", {"color":"aqua"})
    rarity = "epic"
    category = ["elemental","helmet"]
    stats = ("head", {"armor":20,"mana_pool":60,"ability_haste":5})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# CowlOfTheOverseer
@add_loot_table
@bolt_item
class CowlOfTheOverseer(GenesisItem):
    item_name = ("CowlOfTheOverseer", {"color":"dark_red"})
    rarity = "legendary"
    category = ["helmet"]
    stats = ("head", {"armor":30,"mana_pool":70,"ability_haste":10})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}