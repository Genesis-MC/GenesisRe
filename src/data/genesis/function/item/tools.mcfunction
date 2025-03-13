from genesis:utils import texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, BlizzardTear, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, HexedHailstone, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 

#! add these in once minerals are added
# CrystalLens
#@add_custom_recipe([
#    [None, "glass_pane", None],
#    ["glass_pane", CrystalDust, "glass_pane"],
#    [SteelHilt, "glass_pane", None],
#])

# PrismaticPickaxe
#@add_custom_recipe([
#    [PureCrystal, PureCrystal, PureCrystal],
#    [None, BejeweledHilt, None],
#    [None, BejeweledHilt, None],
#])

# NoviceMallet
#@add_custom_recipe([
#    [None, "copper_block", "copper_ingot"],
#    [None, "stick", "copper_block"],
#    ["stick", None, None],
#])

# ApprenticeMallet
#@add_custom_recipe([
#    ["iron_ingot", Inecraft:amethystShard",tag:{gen:{type:["uncommon"],mineral:1, "iron_ingot"],
#    [Inecraft:amethystShard",tag:{gen:{type:["uncommon"],mineral:1, NovicesMallet, Inecraft:amethystShard",tag:{gen:{type:["uncommon"],mineral:1],
#    ["iron_ingot", Inecraft:amethystShard",tag:{gen:{type:["uncommon"],mineral:1, "iron_ingot"],
#])

# JourneymanMallet
#@add_custom_recipe([
#    ["gold_ingot", Inecraft:amethystShard",tag:{gen:{type:["rare"],mineral:1, "gold_ingot"],
#    [Inecraft:amethystShard",tag:{gen:{type:["rare"],mineral:1, ApprenticesMallet, Inecraft:amethystShard",tag:{gen:{type:["rare"],mineral:1],
#    ["gold_ingot", Inecraft:amethystShard",tag:{gen:{type:["rare"],mineral:1, "gold_ingot"],
#])

# ExpertMallet
#@add_custom_recipe([
#    ["diamond", Inecraft:amethystShard",tag:{gen:{type:["epic"],mineral:1, "diamond"],
#    [Inecraft:amethystShard",tag:{gen:{type:["epic"],mineral:1, JourneymansMallet, Inecraft:amethystShard",tag:{gen:{type:["epic"],mineral:1],
#    ["diamond", Inecraft:amethystShard",tag:{gen:{type:["epic"],mineral:1, "diamond"],
#])

# MasterMallet
#@add_custom_recipe([
#    ["netherite_ingot", Inecraft:amethystShard",tag:{gen:{type:["legendary"],mineral:1, "netherite_ingot"],
#    [Inecraft:amethystShard",tag:{gen:{type:["legendary"],mineral:1, ExpertsMallet, Inecraft:amethystShard",tag:{gen:{type:["legendary"],mineral:1],
#    ["netherite_ingot", Inecraft:amethystShard",tag:{gen:{type:["legendary"],mineral:1, "netherite_ingot"],
#])

