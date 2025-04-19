from genesis:utils import texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from genesis:tungsten import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, BlizzardTear, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, HexedHailstone, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 

# IronDagger
@add_custom_recipe([
    [None, None, "iron_ingot"],
    [None, "iron_ingot", None],
    ["stick", None, None],
])
class IronDagger(GenesisItem):
    item_name = ("Iron Dagger", {"color":"white"})
    rarity = "common"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":35,"attack_speed":175})

# Frostfang
@add_custom_recipe([
    [BlizzardTear, BlizzardTear, BlizzardTear],
    [BlizzardTear, WolfFang, BlizzardTear],
    [BlizzardTear, BlizzardTear, BlizzardTear],
])
class Frostfang(GenesisItem):
    item_name = ("Frostfang", {"color":"aqua"})
    rarity = "uncommon"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":25,"attack_speed":175})

# HarbingerOfWinter
@add_custom_recipe([
    [None, None, Frostfang],
    [None, Frostfang, None],
    [SteelHilt, None, None],
])
class HarbingerOfWinter(GenesisItem):
    item_name = ("Harbinger Of Winter", {"color":"aqua"})
    rarity = "rare"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":30,"attack_speed":210,"speed":30})

# ShadedDagger
@add_custom_recipe([
    [ShadeFlux, ShadeFlux, ShadeFlux],
    [ShadeFlux, IronDagger, ShadeFlux],
    [ShadeFlux, ShadeFlux, ShadeFlux],
])
class ShadedDagger(GenesisItem):
    item_name = ("Shaded Dagger", {"color":"dark_purple"})
    rarity = "uncommon"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":40,"attack_speed":175,"speed":15})

# VoidRazor
@add_custom_recipe([
    [VoidedFragment, "crying_obsidian", VoidedFragment],
    [ShadedEnderPearl, ShadedDagger, ShadedEnderPearl],
    [VoidedFragment, "crying_obsidian", VoidedFragment],
])
class VoidRazor(GenesisItem):
    item_name = ("Void Razor", {"color":"dark_purple"})
    rarity = "epic"
    category = ["void", "dagger"]
    stats = ("mainhand", {"physical_power":45,"attack_speed":195,"speed":25})

# Vorpol
@add_custom_recipe([
    [ShardOfTheCrimsonAbyss, PyroclasticCore, ShardOfTheWarpedEmpyrean],
    [VoidedEnderPearl, VoidRazor, VoidedEnderPearl],
    [ShardOfTheWarpedEmpyrean, PyroclasticCore, ShardOfTheCrimsonAbyss],
])
class Vorpol(GenesisItem):
    item_name = ("Vorpol", {"color":"light_purple"})
    rarity = "legendary"
    category = ["void", "dagger"]
    stats = ("mainhand", {"physical_power":50,"attack_speed":175,"speed":100})
    @right_click_ability(
        name = "blitzkrieg",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def blitzkrieg():
        say WIP

# Vescherum
@add_custom_recipe([
    [ShardOfTheCrimsonAbyss, LivingwoodCore, ShardOfTheCrimsonAbyss],
    [VoidedEnderPearl, VoidRazor, VoidedEnderPearl],
    [ShardOfTheCrimsonAbyss, LivingwoodCore, ShardOfTheCrimsonAbyss],
])
class Vescherum(GenesisItem):
    item_name = ("Vescherum", {"color":"light_purple"})
    rarity = "legendary"
    category = ["void", "dagger"]
    stats = ("mainhand", {"physical_power":50,"attack_speed":195,"armor_toughness":60,"speed":30})
    @right_click_ability(
        name = "hallowed_field",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def hallowed_field():
        say WIP

# Visharp
@add_custom_recipe([
    [ShardOfTheWarpedEmpyrean, EverfrostCore, ShardOfTheWarpedEmpyrean],
    [VoidedEnderPearl, VoidRazor, VoidedEnderPearl],
    [ShardOfTheWarpedEmpyrean, EverfrostCore, ShardOfTheWarpedEmpyrean],
])
class Visharp(GenesisItem):
    item_name = ("Visharp", {"color":"light_purple"})
    rarity = "legendary"
    category = ["void", "dagger"]
    stats = ("mainhand", {"physical_power":60,"attack_speed":195})
    @right_click_ability(
        name = "Voidrend",
        description = "Teleport up to 5 blocks ahead of you and deal 40% Physical Power to opponents in a 3-block radius from your initial position",
        mana = 25,
        cooldown = 4,
    )
    def voidrend():
        store result storage genesis:temp item.voidrend.damage float 0.04 scoreboard players get @s genesis.stat.physical_power
        execute function ~/../voidrend_macro with storage genesis:temp item.voidrend: #! we could make use of custom damage types
            $execute as @e[distance=..3,tag=!genesis.player] run damage @s $(damage) minecraft:generic by @a[tag=genesis.caster,limit=1]
        tp ^ ^ ^5 #! This is obviously not final lol

# Hook
class Hook(GenesisItem):
    item_name = ("Hook", {"color":"white"})
    rarity = "uncommon"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":35,"attack_speed":195,"luck":10})

# LadyLuck
class LadyLuck(GenesisItem):
    item_name = ("LadyLuck", {"color":"gold"})
    rarity = "mythical"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":30,"attack_speed":230,"luck":50})

# VermillionGlove
class VermillionGlove(GenesisItem):
    item_name = ("Vermillion Glove", {"color":"dark_red"})
    rarity = "uncommon"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":45,"attack_speed":175})

# CrystalMoon
class CrystalMoon(GenesisItem):
    item_name = ("Crystal Moon", {"color":"white"})
    rarity = "rare"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":30,"attack_speed":175,"armor_toughness":-20,"mana_regen":50})

# PrismDagger
class PrismDagger(GenesisItem):
    item_name = ("Prism Dagger", {"color":"light_purple"})
    rarity = "epic"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":50,"magic_power":100,"attack_speed":185,"mana_regen":100})
    @right_click_ability(
        name = "prism_shatter",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def prism_shatter():
        say WIP