from genesis:utils import texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from genesis:tungsten import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, BlizzardTear, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, HexedHailstone, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 

# IronSpear
@add_custom_recipe([
    [None, "iron_ingot", "iron_ingot"],
    [None, "stick", "iron_ingot"],
    ["stick", None, None],
])
class IronSpear(GenesisItem):
    item_name = ("Iron Spear", {"color":"white"})
    rarity = "common"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":65,"attack_speed":138})

# Glaive
@add_custom_recipe([
    [None, MetalAlloy, MetalAlloy],
    [None, SteelHilt, MetalAlloy],
    [SteelHilt, None, None],
])
class Glaive(GenesisItem):
    item_name = ("Glaive", {"color":"white"})
    rarity = "rare"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":75,"attack_speed":147})
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
class Halycon(GenesisItem):
    item_name = ("Halycon", {"color":"aqua"})
    rarity = "rare"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":75,"attack_speed":155,"speed":40})
    @right_click_ability(
        name = "Windcharmer",
        description = "If used while on the ground, summon a gust of wind which knocks up all enemies in a 3-block radius. If used while in the air, instead grant yourself slow-falling for 4 seconds.",
        mana = 60,
        cooldown = 6,
    )
    def windcharmer():
        execute if block ~ ~-1 ~ air:
            effect give @s minecraft:slow_falling 4
            playsound minecraft:entity.breeze.slide player @a ~ ~ ~ 1 0
            function genesis:utils/particles/circle_rad2 {particle:"cloud", ydirection:-1, speed:0.3}
            function genesis:utils/particles/circle_rad3 {particle:"cloud", ydirection:-1, speed:0.3}
        execute unless block ~ ~-1 ~ air:
            execute as @e[distance=..3,tag=!genesis.player,tag=!non_living] run data merge entity @s {Motion:[0d,1d,0d]}
            summon minecraft:wind_charge ~ ~ ~ {Motion:[0d,-0.1,0d]}
            function genesis:utils/particles/circle_rad2 {particle:"cloud", ydirection:1, speed:0.3}
            function genesis:utils/particles/circle_rad3 {particle:"cloud", ydirection:1, speed:0.6}

# HelixSpear
class HelixSpear(GenesisItem):
    item_name = ("Helix Spear", {"color":"white"})
    rarity = "rare"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":85,"magic_power":60,"attack_speed":120})
    item_model = "genesis:polearm/helix_spear"
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
class HeavensThorn(GenesisItem):
    item_name = ("Heavens Thorn", {"color":"gold"})
    rarity = "epic"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":90,"magic_power":90,"attack_speed":120,"mana_pool":30,"mana_regen":80})
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
class VerdantStaff(GenesisItem):
    item_name = ("Verdant Staff", {"color":"green"})
    rarity = "uncommon"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":50,"attack_speed":120})
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
class VerdantMasterstaff(GenesisItem):
    item_name = ("Verdant Masterstaff", {"color":"green"})
    rarity = "rare"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":55,"attack_speed":120})
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
class VerdantSceptor(GenesisItem):
    item_name = ("Verdant Sceptor", {"color":"green"})
    rarity = "epic"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":60,"attack_speed":120})
    @right_click_ability(
        name = "revitalize3",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def revitalize3():
        say WIP

# SceptorOfTheCrimsonEgg
class SceptorOfTheCrimsonEgg(GenesisItem):
    item_name = ("Sceptor Of The Crimson Egg", {"color":"red"})
    rarity = "epic"
    category = ["polearm"]
    stats = ("mainhand", {"magic_power":100,"attack_speed":120,"mana_pool":50})
    @right_click_ability(
        name = "firebird",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def firebird():
        say WIP