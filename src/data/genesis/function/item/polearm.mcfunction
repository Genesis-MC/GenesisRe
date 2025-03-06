from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, BlizzardTear, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, HexedHailstone, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 

# IronSpear
@add_custom_recipe([
    [None, "iron_ingot", "iron_ingot"],
    [None, "stick", "iron_ingot"],
    ["stick", None, None],
])
@add_loot_table
class IronSpear(metaclass=GenesisItem):
    item_name = ("Iron Spear", {"color":"white"})
    rarity = "common"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":65,"attack_speed":80})

# Glaive
@add_custom_recipe([
    [None, MetalAlloy, MetalAlloy],
    [None, SteelHilt, MetalAlloy],
    [SteelHilt, None, None],
])
@add_loot_table
class Glaive(metaclass=GenesisItem):
    item_name = ("Glaive", {"color":"white"})
    rarity = "rare"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":75,"attack_speed":85})
    @right_click_ability(
        name = "stance_swap_onslaught",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def stance_swap_onslaught():
        say WIP

# Halycon
@add_custom_recipe([
    [None, CrystalScale, "diamond_block"],
    [CrystalScale, SteelHilt, CrystalScale],
    [SteelHilt, CrystalScale, None],
])
@add_loot_table
class Halycon(metaclass=GenesisItem):
    item_name = ("Halycon", {"color":"aqua"})
    rarity = "rare"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":75,"attack_speed":90,"speed":40})
    @right_click_ability(
        name = "windcharmer",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def windcharmer():
        say WIP

# HelixSpear
@add_loot_table
class HelixSpear(metaclass=GenesisItem):
    item_name = ("Helix Spear", {"color":"white"})
    rarity = "rare"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":85,"magic_power":60,"attack_speed":70})
    @right_click_ability(
        name = "piercing_light",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def piercing_light():
        say WIP

# HeavensThorn
@add_custom_recipe([
    [None, "gold_block", None],
    [HelixSpear, "quartz", HelixSpear],
    [None, GildedHilt, None],
])
@add_loot_table
class HeavensThorn(metaclass=GenesisItem):
    item_name = ("Heavens Thorn", {"color":"gold"})
    rarity = "epic"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":90,"magic_power":90,"attack_speed":70,"mana_pool":30,"mana_regen":8})
    @right_click_ability(
        name = "piercing_light",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def piercing_light():
        say WIP

# VerdantStaff
@add_custom_recipe([
    [None, None, VerdantGem],
    [None, VerdantTwig, None],
    [VerdantTwig, None, None],
])
@add_loot_table
class VerdantStaff(metaclass=GenesisItem):
    item_name = ("Verdant Staff", {"color":"green"})
    rarity = "uncommon"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":50,"attack_speed":70})
    @right_click_ability(
        name = "revitalize1",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def revitalize1():
        say WIP

# VerdantMasterstaff
@add_custom_recipe([
    [VerdantShard, VerdantShard, VerdantShard],
    [VerdantShard, VerdantStaff, VerdantShard],
    [VerdantShard, VerdantShard, VerdantShard],
])
@add_loot_table
class VerdantMasterstaff(metaclass=GenesisItem):
    item_name = ("Verdant Masterstaff", {"color":"green"})
    rarity = "rare"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":55,"attack_speed":70})
    @right_click_ability(
        name = "revitalize2",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def revitalize2():
        say WIP

# VerdantSceptor
@add_custom_recipe([
    [CrystalScale, VerdantGem, CrystalScale],
    [VerdantGem, VerdantMasterstaff, VerdantGem],
    [CrystalScale, VerdantGem, CrystalScale],
])
@add_loot_table
class VerdantSceptor(metaclass=GenesisItem):
    item_name = ("Verdant Sceptor", {"color":"green"})
    rarity = "epic"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":60,"attack_speed":70})
    @right_click_ability(
        name = "revitalize3",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def revitalize3():
        say WIP

# SceptorOfTheCrimsonEgg
@add_loot_table
class SceptorOfTheCrimsonEgg(metaclass=GenesisItem):
    item_name = ("Sceptor Of The Crimson Egg", {"color":"red"})
    rarity = "epic"
    category = ["polearm"]
    stats = ("mainhand", {"magic_power":100,"attack_speed":70,"mana_pool":50})
    @right_click_ability(
        name = "firebird",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def firebird():
        say WIP