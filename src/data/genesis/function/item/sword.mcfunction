from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, BlizzardTear, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, HexedHailstone, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 

# ObsidianBlade
@add_custom_recipe([
    [None, None, "obsidian"],
    [None, "obsidian", None],
    [SteelHilt, None, None],
])
@add_loot_table
class ObsidianBlade(metaclass=GenesisItem):
    item_name = ("Obsidian Blade", {"color":"white"})
    rarity = "uncommon"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":80,"attack_speed":85,"armor":-10})

# FadingDusk
@add_custom_recipe([
    [ShadeFlux, ShadeFlux, ShadeFlux],
    ["obsidian", ObsidianBlade, "obsidian"],
    [ShadeFlux, ShadeFlux, ShadeFlux],
])
@add_loot_table
class FadingDusk(metaclass=GenesisItem):
    item_name = ("Fading Dusk", {"color":"dark_purple"})
    rarity = "rare"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":80,"attack_speed":85,"armor":-10})

# SaberCrimson
@add_custom_recipe([
    [None, None, CrimsonAlloy],
    [None, CrimsonAlloy, None],
    [BejeweledHilt, None, None],
])
@add_loot_table
class SaberCrimson(metaclass=GenesisItem):
    item_name = ("Saber Crimson", {"color":"red"})
    rarity = "epic"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":85,"attack_speed":95,"health":-40})

# SaberWarped
@add_custom_recipe([
    [None, None, WarpedAlloy],
    [None, WarpedAlloy, None],
    [BejeweledHilt, None, None],
])
@add_loot_table
class SaberWarped(metaclass=GenesisItem):
    item_name = ("Saber Warped", {"color":"dark_aqua"})
    rarity = "epic"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":85,"attack_speed":95,"mana_regen":-30})

# HailstoneBlade
@add_loot_table
class HailstoneBlade(metaclass=GenesisItem):
    item_name = ("Hailstone Blade", {"color":"aqua"})
    rarity = "epic"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":75,"attack_speed":100})
    @right_click_ability(
        name = "hailslash",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def hailslash():
        say WIP

# Kopesh
@add_loot_table
class Kopesh(metaclass=GenesisItem):
    item_name = ("Kopesh", {"color":"dark_red"})
    rarity = "rare"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":80,"attack_speed":85})
    @right_click_ability(
        name = "cleave1",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def cleave1():
        say WIP

# AcolyteBlade
@add_loot_table
class AcolyteBlade(metaclass=GenesisItem):
    item_name = ("Acolyte Blade", {"color":"dark_red"})
    rarity = "rare"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":85,"attack_speed":80})

# Asophogheny
@add_loot_table
class Asophogeny(metaclass=GenesisItem):
    item_name = ("Asophogeny", {"color":"dark_red"})
    rarity = "epic"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":100,"magic_power":90,"attack_speed":80})
    @right_click_ability(
        name = "blood_root",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def blood_root():
        say WIP