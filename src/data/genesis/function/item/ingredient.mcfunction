from genesis:utils import break_text_into_lines, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from genesis:tungsten import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

# Steelhilt
@add_custom_recipe([
    ["iron_ingot", "iron_ingot", "iron_ingot"],
    ["iron_ingot", "stick", "iron_ingot"],
    ["iron_ingot", "iron_ingot", "iron_ingot"],
])
class SteelHilt(GenesisItem):
    item_name = ("Steel Hilt", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.steel_hilt.lore",
        italic = True,
    )

# Gildedhilt
@add_custom_recipe([
    ["gold_ingot", "gold_ingot", "gold_ingot"],
    ["gold_ingot", SteelHilt, "gold_ingot"],
    ["gold_ingot", "gold_ingot", "gold_ingot"],
])
class GildedHilt(GenesisItem):
    item_name = ("Gilded Hilt", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.gilded_hilt.lore",
        italic = True,
    )

# Bejeweledhilt
@add_custom_recipe([
    ["diamond", "diamond", "diamond"],
    ["diamond", GildedHilt, "diamond"],
    ["diamond", "diamond", "diamond"],
])
class BejeweledHilt(GenesisItem):
    item_name = ("Bejeweled Hilt", {"color":"white"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.bejeweled_hilt.lore",
        italic = True,
    )
#! add in once minerals are added in
# CrimsonAlloy
#@add_custom_recipe([
#    [NetheriteSediment, ShardOfTheCrimsonAbyss, NetheriteSediment],
#    [ShardOfTheCrimsonAbyss, MetalAlloy, ShardOfTheCrimsonAbyss],
#    [NetheriteSediment, ShardOfTheCrimsonAbyss, NetheriteSediment],
#])
class CrimsonAlloy(GenesisItem):
    item_name = ("Crimson Alloy", {"color":"red"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.crimson_alloy.lore",
        italic = True,
    )

# WarpedAlloy
#@add_custom_recipe([
#    [NetheriteSediment, ShardOfTheWarpedEmpyrean, NetheriteSediment],
#    [ShardOfTheWarpedEmpyrean, MetalAlloy, ShardOfTheWarpedEmpyrean],
#    [NetheriteSediment, ShardOfTheWarpedEmpyrean, NetheriteSediment],
#])
class WarpedAlloy(GenesisItem):
    item_name = ("Warped Alloy", {"color":"dark_aqua"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.warped_alloy.lore",
        italic = True,
    )
    
class VerdantTwig(GenesisItem):
    item_name = ("Verdant Twig", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.verdant_twig.lore",
        italic = True,
    )
    
class MossyBark(GenesisItem):
    item_name = ("Mossy Bark", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.mossy_bark.lore",
        italic = True,
    )

# VerdantGem
@add_custom_recipe([
    [VerdantTwig, MossyBark, VerdantTwig],
    [MossyBark, "emerald", MossyBark],
    [VerdantTwig, MossyBark, VerdantTwig],
])
class VerdantGem(GenesisItem):
    item_name = ("Verdant Gem", {"color":"green"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.verdant_gem.lore",
        italic = True,
    )

class VermillionClay(GenesisItem):
    item_name = ("Vermillion Clay", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.vermillion_clay.lore",
        italic = True,
    )
    
# VermillionGem
@add_custom_recipe([
    [VermillionClay, VermillionClay, VermillionClay],
    [VermillionClay, "diamond", VermillionClay],
    [VermillionClay, VermillionClay, VermillionClay],
])
class VermillionGem(GenesisItem):
    item_name = ("Vermillion Gem", {"color":"dark_red"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.vermillion_gem.lore",
        italic = True,
    )

class ShadeFlux(GenesisItem):
    item_name = ("Shade Flux", {"color":"dark_purple"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "Mesmerizingly beautiful... and beautifully ominous",
        "item.genesis.shade_flux.lore",
        italic = True,
    )

# ShadedEnderPearl
@add_custom_recipe([
    [None, ShadeFlux, None],
    [ShadeFlux, "ender_pearl", ShadeFlux],
    [None, ShadeFlux, None],
])
class ShadedEnderPearl(GenesisItem):
    item_name = ("Shaded Ender Pearl", {"color":"light_purple"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.shaded_ender_pearl.lore",
        italic = True,
    )

class VoidedFragment(GenesisItem):
    item_name = ("Voided Fragment", {"color":"dark_purple"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.voided_fragment.lore",
        italic = True,
    )

# VoidedEnderPearl
@add_custom_recipe([
    [None, VoidedFragment, None],
    [VoidedFragment, ShadedEnderPearl, VoidedFragment],
    [None, VoidedFragment, None],
])
class VoidedEnderPearl(GenesisItem):
    item_name = ("Voided Ender Pearl", {"color":"dark_purple"})
    rarity = "epic"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.voided_ender_pearl.lore",
        italic = True,
    )

#! add in later w/ other minerals
# PureCrystal
#@add_custom_recipe([
#    [PureCrystalDust, PureCrystalDust, PureCrystalDust],
#    [PureCrystalDust, "amethyst_shard", PureCrystalDust],
#    [PureCrystalDust, PureCrystalDust, PureCrystalDust],
#])

# YellowEnhancementCrystal
#@add_custom_recipe([
#    [CrystalDust, CrystalDust, CrystalDust],
#    [CrystalDust, "amethyst_shard", CrystalDust],
#    [CrystalDust, CrystalDust, CrystalDust],
#])

# PinkEnhancementCrystal
#@add_custom_recipe([
#    [None, YellowEnhancementCrystal, None],
#    [YellowEnhancementCrystal, "amethyst_shard", YellowEnhancementCrystal],
#    [None, YellowEnhancementCrystal, None],
#])

# CrimsonEnhancementCrystal
#@add_custom_recipe([
#    [None, PinkEnhancementCrystal, None],
#    [PinkEnhancementCrystal, "amethyst_shard", PinkEnhancementCrystal],
#    [None, PinkEnhancementCrystal, None],
#])

# CeruleanEnhancementCrystal
#@add_custom_recipe([
#    [None, CrimsonEnhancementCrystal, None],
#    [CrimsonEnhancementCrystal, "amethyst_shard", CrimsonEnhancementCrystal],
#    [None, CrimsonEnhancementCrystal, None],
#])

class AncientGoldCoin(GenesisItem):
    item_name = ("Ancient Gold Coin", {"color":"white"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.ancient_gold_coin.lore",
        italic = True,
    )

class ArcaneCloth(GenesisItem):
    item_name = ("Arcane Cloth", {"color":"light_purple"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.arcane_cloth.lore",
        italic = True,
    )

class Frostflake(GenesisItem):
    item_name = ("Frostflake", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.frostflake.lore",
        italic = True,
    )

class BoarHide(GenesisItem):
    item_name = ("Boar Hide", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.boar_hide.lore",
        italic = True,
    )

class Calimari(GenesisItem):
    item_name = ("Calimari", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.calimari.lore",
        italic = True,
    )

class Cloth(GenesisItem):
    item_name = ("Cloth", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.cloth.lore",
        italic = True,
    )

class CrystalDust(GenesisItem):
    item_name = ("Crystal Dust", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.crystal_dust.lore",
        italic = True,
    )

class CrystalScale(GenesisItem):
    item_name = ("Crystal Scale", {"color":"aqua"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.crystal_scale.lore",
        italic = True,
    )

class Drumstick(GenesisItem):
    item_name = ("Drumstick", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.drumstick.lore",
        italic = True,
    )

class FloralNectar(GenesisItem):
    item_name = ("Floral Nectar", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.floral_nectar.lore",
        italic = True,
    )

class FrozenWisp(GenesisItem):
    item_name = ("Frozen Wisp", {"color":"white"})
    rarity = "epic"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.frozen_wisp.lore",
        italic = True,
    )

class EverfrostCore(GenesisItem):
    item_name = ("Everfrost Core", {"color":"white"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.everfrost_core.lore",
        italic = True,
    )

class LivingwoodCore(GenesisItem):
    item_name = ("Livingwood Core", {"color":"green"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.livingwood_core.lore",
        italic = True,
    )

class PyroclasticCore(GenesisItem):
    item_name = ("Pyroclastic Core", {"color":"red"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.pyroclastic_core.lore",
        italic = True,
    )

class ManaCloth(GenesisItem):
    item_name = ("Mana Cloth", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.mana_cloth.lore",
        italic = True,
    )

class MetalAlloy(GenesisItem):
    item_name = ("Metal Alloy", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.metal_alloy.lore",
        italic = True,
    )

class MutatedFlesh(GenesisItem):
    item_name = ("Mutated Flesh", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.mutated_flesh.lore",
        italic = True,
    )

class Octopus(GenesisItem):
    item_name = ("Octopus", {"color":"white"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.octopus.lore",
        italic = True,
    )

class PrimeBeef(GenesisItem):
    item_name = ("Prime Beef", {"color":"white"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.prime_beef.lore",
        italic = True,
    )

class PureCrystalDust(GenesisItem):
    item_name = ("Pure Crystal Dust", {"color":"light_purple"})
    rarity = "epic"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.pure_crystal_dust.lore",
        italic = True,
    )

class ScrapscuttleEgg(GenesisItem):
    item_name = ("Scrapscuttle Egg", {"color":"white"})
    rarity = "epic"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.scrapscuttle_egg.lore",
        italic = True,
    )

class ShardOfTheCrimsonAbyss(GenesisItem):
    item_name = ("Shard Of The Crimson Abyss", {"color":"red"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.shard_of_the_crimson_abyss.lore",
        italic = True,
    )

class ShardOfTheDepths(GenesisItem):
    item_name = ("Shard Of The Depths", {"color":"dark_purple"})
    rarity = "epic"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.shard_of_the_depths.lore",
        italic = True,
    )

class ShardOfTheWarpedEmpyrean(GenesisItem):
    item_name = ("Shard Of The Warped Empyrean", {"color":"dark_aqua"})
    rarity = "epic"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.shard_of_the_warped_empyrean.lore",
        italic = True,
    )

class TerraclodPearl(GenesisItem):
    item_name = ("Terraclod Pearl", {"color":"gold"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.terraclod_pearl.lore",
        italic = True,
    )

class Truffle(GenesisItem):
    item_name = ("Truffle", {"color":"white"})
    rarity = "epic"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.truffle.lore",
        italic = True,
    )

class VenomSac(GenesisItem):
    item_name = ("Venom Sac", {"color":"white"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.venom_sac.lore",
        italic = True,
    )

class VerdantShard(GenesisItem):
    item_name = ("Verdant Shard", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.verdant_shard.lore",
        italic = True,
    )

class WizardsTruffle(GenesisItem):
    item_name = ("Wizards Truffle", {"color":"blue"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.wizards_truffle.lore",
        italic = True,
    )

class WolfFang(GenesisItem):
    item_name = ("Wolf Fang", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.wolf_fang.lore",
        italic = True,
    )