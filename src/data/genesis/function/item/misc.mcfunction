from genesis:utils import break_text_into_lines, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, BlizzardTear, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, HexedHailstone, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 

#! add in once crops are added in
# EnhancedManaCookie
#@add_custom_recipe([
#    [None, ManaBean, None],
#    [ManaBean, ManaCookie, ManaBean],
#    [None, ManaBean, None],
#])

# AuricManaCookie
#@add_custom_recipe([
#    [None, ManaBean, None],
#    [ManaBean, EnhancedManaCookie, ManaBean],
#    [None, ManaBean, None],
#])

#! add in once minerals are added in
# CrystalNode
#@add_custom_recipe([
#    ["amethyst_shard", "glass", "amethyst_shard"],
#    ["glass", CrystalBuds, "glass"],
#    ["amethyst_shard", "glass", "amethyst_shard"],
#])

# PiratesBounty
#@add_custom_recipe([
#    [AncientGoldCoin, AncientGoldCoin, AncientGoldCoin],
#    [AncientGoldCoin, "chest", AncientGoldCoin],
#    [AncientGoldCoin, AncientGoldCoin, AncientGoldCoin],
#])

# HeartOfTheDepths
#@add_custom_recipe([
#    [ShardOfTheDepths, ShardOfTheDepths, ShardOfTheDepths],
#    [ShardOfTheDepths, "chest", ShardOfTheDepths],
#    [ShardOfTheDepths, ShardOfTheDepths, ShardOfTheDepths],
#])