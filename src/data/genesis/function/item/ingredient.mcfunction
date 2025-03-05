from ps_beet_bolt.bolt_item import bolt_item
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
@bolt_item
class SteelHilt(GenesisItem):
    item_name = ("Steel Hilt", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/steel_hilt")
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
@bolt_item
class GildedHilt(GenesisItem):
    item_name = ("Gilded Hilt", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/gilded_hilt")
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
@bolt_item
class BejeweledHilt(GenesisItem):
    item_name = ("Bejeweled Hilt", {"color":"white"})
    rarity = "rare"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/bejeweled_hilt")
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
@bolt_item
class CrimsonAlloy(GenesisItem):
    item_name = ("Crimson Alloy", {"color":"red"})
    rarity = "legendary"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/crimson_alloy")
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
@bolt_item
class WarpedAlloy(GenesisItem):
    item_name = ("Warped Alloy", {"color":"dark_aqua"})
    rarity = "legendary"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/warped_alloy")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.warped_alloy.lore",
        italic = True,
    )
    
@add_loot_table
@bolt_item
class VerdantTwig(GenesisItem):
    item_name = ("Verdant Twig", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/verdant_twig")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.verdant_twig.lore",
        italic = True,
    )
    
@add_loot_table
@bolt_item
class MossyBark(GenesisItem):
    item_name = ("Mossy Bark", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/mossy_bark")
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
@bolt_item
class VerdantGem(GenesisItem):
    item_name = ("Verdant Gem", {"color":"green"})
    rarity = "uncommon"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/verdant_gem")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.verdant_gem.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class VermillionClay(GenesisItem):
    item_name = ("Vermillion Clay", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/vermillion_clay")
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
@bolt_item
class VermillionGem(GenesisItem):
    item_name = ("Vermillion Gem", {"color":"dark_red"})
    rarity = "uncommon"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/vermillion_gem")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.vermillion_gem.lore",
        italic = True,
    )

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

# ShadedEnderPearl
@add_custom_recipe([
    [None, ShadeFlux, None],
    [ShadeFlux, "ender_pearl", ShadeFlux],
    [None, ShadeFlux, None],
])
@add_loot_table
@bolt_item
class ShadedEnderPearl(GenesisItem):
    item_name = ("Shaded Ender Pearl", {"color":"light_purple"})
    rarity = "rare"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/shaded_ender_pearl")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.shaded_ender_pearl.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class VoidedFragment(GenesisItem):
    item_name = ("Voided Fragment", {"color":"dark_purple"})
    rarity = "rare"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/voided_fragment")
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
@bolt_item
class VoidedEnderPearl(GenesisItem):
    item_name = ("Voided Ender Pearl", {"color":"dark_purple"})
    rarity = "epic"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/voided_ender_pearl")
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
@bolt_item
class AncientGoldCoin(GenesisItem):
    item_name = ("Ancient Gold Coin", {"color":"white"})
    rarity = "rare"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/ancient_gold_coin")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.ancient_gold_coin.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class ArcaneCloth(GenesisItem):
    item_name = ("Arcane Cloth", {"color":"light_purple"})
    rarity = "rare"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/arcane_cloth")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.arcane_cloth.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class BlizzardTear(GenesisItem):
    item_name = ("Blizzard Tear", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/blizzard_tear")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.blizzard_tear.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class BoarHide(GenesisItem):
    item_name = ("Boar Hide", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/boar_hide")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.boar_hide.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class Calimari(GenesisItem):
    item_name = ("Calimari", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/calimari")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.calimari.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class Cloth(GenesisItem):
    item_name = ("Cloth", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/cloth")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.cloth.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class CrystalDust(GenesisItem):
    item_name = ("Crystal Dust", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/crystal_dust")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.crystal_dust.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class CrystalScale(GenesisItem):
    item_name = ("Crystal Scale", {"color":"aqua"})
    rarity = "rare"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/crystal_scale")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.crystal_scale.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class Drumstick(GenesisItem):
    item_name = ("Drumstick", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/drumstick")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.drumstick.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class FloralNectar(GenesisItem):
    item_name = ("Floral Nectar", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/floral_nectar")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.floral_nectar.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class HexedHailstone(GenesisItem):
    item_name = ("Hexed Hailstone", {"color":"white"})
    rarity = "epic"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/hexed_hailstone")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.hexed_hailstone.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class EverfrostCore(GenesisItem):
    item_name = ("Everfrost Core", {"color":"white"})
    rarity = "legendary"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/everfrost_core")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.everfrost_core.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class LivingwoodCore(GenesisItem):
    item_name = ("Livingwood Core", {"color":"green"})
    rarity = "legendary"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/livingwood_core")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.livingwood_core.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class PyroclasticCore(GenesisItem):
    item_name = ("Pyroclastic Core", {"color":"red"})
    rarity = "legendary"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/pyroclastic_core")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.pyroclastic_core.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class ManaCloth(GenesisItem):
    item_name = ("Mana Cloth", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/mana_cloth")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.mana_cloth.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class MetalAlloy(GenesisItem):
    item_name = ("Metal Alloy", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/metal_alloy")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.metal_alloy.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class MutatedFlesh(GenesisItem):
    item_name = ("Mutated Flesh", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/mutated_flesh")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.mutated_flesh.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class PrimeBeef(GenesisItem):
    item_name = ("Prime Beef", {"color":"white"})
    rarity = "rare"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/prime_beef")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.prime_beef.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class PureCrystalDust(GenesisItem):
    item_name = ("Pure Crystal Dust", {"color":"light_purple"})
    rarity = "epic"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/pure_crystal_dust")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.pure_crystal_dust.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class ScrapscuttleEgg(GenesisItem):
    item_name = ("Scrapscuttle Egg", {"color":"white"})
    rarity = "epic"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/scrapscuttle_egg")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.scrapscuttle_egg.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class ShardOfTheCrimsonAbyss(GenesisItem):
    item_name = ("Shard Of The Crimson Abyss", {"color":"red"})
    rarity = "legendary"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/shard_of_the_crimson_abyss")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.shard_of_the_crimson_abyss.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class ShardOfTheDepths(GenesisItem):
    item_name = ("Shard Of The Depths", {"color":"dark_purple"})
    rarity = "epic"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/shard_of_the_depths")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.shard_of_the_depths.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class ShardOfTheWarpedEmpyrean(GenesisItem):
    item_name = ("Shard Of The Warped Empyrean", {"color":"dark_aqua"})
    rarity = "epic"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/shard_of_the_warped_empyrean")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.shard_of_the_warped_empyrean.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class TerraclodPearl(GenesisItem):
    item_name = ("Terraclod Pearl", {"color":"gold"})
    rarity = "legendary"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/terraclod_pearl")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.terraclod_pearl.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class Truffle(GenesisItem):
    item_name = ("Truffle", {"color":"white"})
    rarity = "epic"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/truffle")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.truffle.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class VenomSac(GenesisItem):
    item_name = ("Venom Sac", {"color":"white"})
    rarity = "rare"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/venom_sac")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.venom_sac.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class VerdantShard(GenesisItem):
    item_name = ("Verdant Shard", {"color":"white"})
    rarity = "uncommon"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/verdant_shard")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.verdant_shard.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class WizardsTruffle(GenesisItem):
    item_name = ("Wizards Truffle", {"color":"blue"})
    rarity = "legendary"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/wizards_truffle")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.wizards_truffle.lore",
        italic = True,
    )

@add_loot_table
@bolt_item
class WolfFang(GenesisItem):
    item_name = ("Wolf Fang", {"color":"white"})
    rarity = "common"
    category = ["ingredient"]
    item_model = texture_path_to_item_model("genesis:item/ingredient/wolf_fang")
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.wolf_fang.lore",
        italic = True,
    )