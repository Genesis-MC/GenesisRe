from genesis:utils import add_loot_table, break_text_into_lines, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
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
@add_loot_table
class SteelHilt(metaclass=GenesisItem):
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
@add_loot_table
class GildedHilt(metaclass=GenesisItem):
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
@add_loot_table
class BejeweledHilt(metaclass=GenesisItem):
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
@add_loot_table
class CrimsonAlloy(metaclass=GenesisItem):
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
@add_loot_table
class WarpedAlloy(metaclass=GenesisItem):
    item_name = ("Warped Alloy", {"color":"dark_aqua"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.warped_alloy.lore",
        italic = True,
    )
    
@add_loot_table
class VerdantTwig(metaclass=GenesisItem):
    item_name = ("Verdant Twig", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.verdant_twig.lore",
        italic = True,
    )
    
@add_loot_table
class MossyBark(metaclass=GenesisItem):
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
@add_loot_table
class VerdantGem(metaclass=GenesisItem):
    item_name = ("Verdant Gem", {"color":"green"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.verdant_gem.lore",
        italic = True,
    )

@add_loot_table
class VermillionClay(metaclass=GenesisItem):
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
@add_loot_table
class VermillionGem(metaclass=GenesisItem):
    item_name = ("Vermillion Gem", {"color":"dark_red"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.vermillion_gem.lore",
        italic = True,
    )

@add_loot_table
class ShadeFlux(metaclass=GenesisItem):
    item_name = ("Shade Flux", {"color":"dark_purple"})
    rarity = "uncommon"
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
@add_loot_table
class ShadedEnderPearl(metaclass=GenesisItem):
    item_name = ("Shaded Ender Pearl", {"color":"light_purple"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.shaded_ender_pearl.lore",
        italic = True,
    )

@add_loot_table
class VoidedFragment(metaclass=GenesisItem):
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
@add_loot_table
class VoidedEnderPearl(metaclass=GenesisItem):
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

@add_loot_table
class AncientGoldCoin(metaclass=GenesisItem):
    item_name = ("Ancient Gold Coin", {"color":"white"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.ancient_gold_coin.lore",
        italic = True,
    )

@add_loot_table
class ArcaneCloth(metaclass=GenesisItem):
    item_name = ("Arcane Cloth", {"color":"light_purple"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.arcane_cloth.lore",
        italic = True,
    )

@add_loot_table
class BlizzardTear(metaclass=GenesisItem):
    item_name = ("Blizzard Tear", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.blizzard_tear.lore",
        italic = True,
    )

@add_loot_table
class BoarHide(metaclass=GenesisItem):
    item_name = ("Boar Hide", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.boar_hide.lore",
        italic = True,
    )

@add_loot_table
class Calimari(metaclass=GenesisItem):
    item_name = ("Calimari", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.calimari.lore",
        italic = True,
    )

@add_loot_table
class Cloth(metaclass=GenesisItem):
    item_name = ("Cloth", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.cloth.lore",
        italic = True,
    )

@add_loot_table
class CrystalDust(metaclass=GenesisItem):
    item_name = ("Crystal Dust", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.crystal_dust.lore",
        italic = True,
    )

@add_loot_table
class CrystalScale(metaclass=GenesisItem):
    item_name = ("Crystal Scale", {"color":"aqua"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.crystal_scale.lore",
        italic = True,
    )

@add_loot_table
class Drumstick(metaclass=GenesisItem):
    item_name = ("Drumstick", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.drumstick.lore",
        italic = True,
    )

@add_loot_table
class FloralNectar(metaclass=GenesisItem):
    item_name = ("Floral Nectar", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.floral_nectar.lore",
        italic = True,
    )

@add_loot_table
class HexedHailstone(metaclass=GenesisItem):
    item_name = ("Hexed Hailstone", {"color":"white"})
    rarity = "epic"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.hexed_hailstone.lore",
        italic = True,
    )

@add_loot_table
class EverfrostCore(metaclass=GenesisItem):
    item_name = ("Everfrost Core", {"color":"white"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.everfrost_core.lore",
        italic = True,
    )

@add_loot_table
class LivingwoodCore(metaclass=GenesisItem):
    item_name = ("Livingwood Core", {"color":"green"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.livingwood_core.lore",
        italic = True,
    )

@add_loot_table
class PyroclasticCore(metaclass=GenesisItem):
    item_name = ("Pyroclastic Core", {"color":"red"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.pyroclastic_core.lore",
        italic = True,
    )

@add_loot_table
class ManaCloth(metaclass=GenesisItem):
    item_name = ("Mana Cloth", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.mana_cloth.lore",
        italic = True,
    )

@add_loot_table
class MetalAlloy(metaclass=GenesisItem):
    item_name = ("Metal Alloy", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.metal_alloy.lore",
        italic = True,
    )

@add_loot_table
class MutatedFlesh(metaclass=GenesisItem):
    item_name = ("Mutated Flesh", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.mutated_flesh.lore",
        italic = True,
    )

@add_loot_table
class PrimeBeef(metaclass=GenesisItem):
    item_name = ("Prime Beef", {"color":"white"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.prime_beef.lore",
        italic = True,
    )

@add_loot_table
class PureCrystalDust(metaclass=GenesisItem):
    item_name = ("Pure Crystal Dust", {"color":"light_purple"})
    rarity = "epic"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.pure_crystal_dust.lore",
        italic = True,
    )

@add_loot_table
class ScrapscuttleEgg(metaclass=GenesisItem):
    item_name = ("Scrapscuttle Egg", {"color":"white"})
    rarity = "epic"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.scrapscuttle_egg.lore",
        italic = True,
    )

@add_loot_table
class ShardOfTheCrimsonAbyss(metaclass=GenesisItem):
    item_name = ("Shard Of The Crimson Abyss", {"color":"red"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.shard_of_the_crimson_abyss.lore",
        italic = True,
    )

@add_loot_table
class ShardOfTheDepths(metaclass=GenesisItem):
    item_name = ("Shard Of The Depths", {"color":"dark_purple"})
    rarity = "epic"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.shard_of_the_depths.lore",
        italic = True,
    )

@add_loot_table
class ShardOfTheWarpedEmpyrean(metaclass=GenesisItem):
    item_name = ("Shard Of The Warped Empyrean", {"color":"dark_aqua"})
    rarity = "epic"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.shard_of_the_warped_empyrean.lore",
        italic = True,
    )

@add_loot_table
class TerraclodPearl(metaclass=GenesisItem):
    item_name = ("Terraclod Pearl", {"color":"gold"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.terraclod_pearl.lore",
        italic = True,
    )

@add_loot_table
class Truffle(metaclass=GenesisItem):
    item_name = ("Truffle", {"color":"white"})
    rarity = "epic"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.truffle.lore",
        italic = True,
    )

@add_loot_table
class VenomSac(metaclass=GenesisItem):
    item_name = ("Venom Sac", {"color":"white"})
    rarity = "rare"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.venom_sac.lore",
        italic = True,
    )

@add_loot_table
class VerdantShard(metaclass=GenesisItem):
    item_name = ("Verdant Shard", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.verdant_shard.lore",
        italic = True,
    )

@add_loot_table
class WizardsTruffle(metaclass=GenesisItem):
    item_name = ("Wizards Truffle", {"color":"blue"})
    rarity = "legendary"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.wizards_truffle.lore",
        italic = True,
    )

@add_loot_table
class WolfFang(metaclass=GenesisItem):
    item_name = ("Wolf Fang", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.wolf_fang.lore",
        italic = True,
    )