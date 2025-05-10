from genesis:utils import texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from genesis:tungsten import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem
from genesis:mana import add_mana

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
        description = "Teleport up to 5 blocks ahead of you and deal 40% Physical Power to opponents in a 2-block radius from both your initial and landing position.",
        mana = 25,
        cooldown = 4,
    )
    def voidrend():
        playsound entity.enderman.teleport player @a ~ ~ ~
        function genesis:utils/particles/transition_circle {particle:"reverse_portal", ydirection:0, speed:0.1}
        function genesis:utils/particles/transition_circle {particle:"reverse_portal", ydirection:0, speed:0.15}
        function genesis:utils/particles/transition_circle {particle:"reverse_portal", ydirection:0, speed:0.05}
        store result storage genesis:temp item.voidrend.damage float 0.04 scoreboard players get @s genesis.stat.physical_power
        execute function ~/../voidrend_macro with storage genesis:temp item.voidrend: #! we could make use of custom damage types
            $execute as @e[distance=..3,tag=!genesis.player] run damage @s $(damage) minecraft:generic by @a[tag=genesis.caster,limit=1]
        execute anchored eyes if block ^ ^ ^5 air if block ^ ^ ^4 air if block ^ ^ ^3 air if block ^ ^ ^2 air if block ^ ^ ^1 air run teleport @s ^ ^ ^5
        execute anchored eyes unless block ^ ^ ^5 air if block ^ ^ ^4 air if block ^ ^ ^3 air if block ^ ^ ^2 air if block ^ ^ ^1 air run teleport @s ^ ^ ^4
        execute anchored eyes unless block ^ ^ ^4 air if block ^ ^ ^3 air if block ^ ^ ^2 air if block ^ ^ ^1 air run teleport @s ^ ^ ^3
        execute anchored eyes unless block ^ ^ ^3 air if block ^ ^ ^2 air if block ^ ^ ^1 air run teleport @s ^ ^ ^2
        execute anchored eyes unless block ^ ^ ^2 air if block ^ ^ ^1 air run teleport @s ^ ^ ^1
        execute at @s positioned ~ ~-1 ~:
            function genesis:utils/particles/transition_circle {particle:"portal", ydirection:0, speed:1}
            function genesis:utils/particles/transition_circle {particle:"portal", ydirection:0, speed:1.2}
            function genesis:utils/particles/transition_circle {particle:"portal", ydirection:0, speed:0.8}

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
    stats = ("mainhand", {"physical_power":50,"magic_power":100,"attack_speed":185})
    passives = [{
        "name": "Arcane Edge",
        "description": "Gain 40% of your Magic Power as Physical Power.",
    }, {
        "name": "Manalust",
        "description": "Restore 3% of your max mana on hit.",
    }]

    @on_attack(slot = 'mainhand')
    def manalust():
        execute on attacker:
            scoreboard players set #denominator genesis 67
            execute store result score #mana genesis run scoreboard players get @s genesis.mana.max
            scoreboard players operation #mana genesis /= #denominator genesis
            add_mana(amount = ["#mana", "genesis"])

    @on_equip(slot = 'mainhand') # Btw any way for on_equip/unequip to trigger for all slots instead of one
    def arcane_edge_add():
        execute store result score @s genesis.passive.arcane_edge_statboost run scoreboard players get @s genesis.stat.magic_power # This works fine, the weapons magic power (100) is stored; If you try to store the physical power, 10 isntead of 50 is stored
        scoreboard players set #multiplier genesis 4
        scoreboard players set #denominator genesis 10
        scoreboard players operation @s genesis.passive.arcane_edge_statboost *= #multiplier genesis
        scoreboard players operation @s genesis.passive.arcane_edge_statboost /= #denominator genesis
        scoreboard players operation @s genesis.passive.arcane_edge_statboost += @s genesis.stat.physical_power # Instead of adding 50, it adds 10
        scoreboard players operation @s genesis.passive.arcane_edge_statboost /= #denominator genesis
        execute store result storage genesis:temp stat.physical_power.value float 1 run scoreboard players get @s genesis.passive.arcane_edge_statboost
        function genesis:utils/macros/physical_power with storage genessi:temp stat.physical_power.value

    @on_unequip(slot = 'mainhand')
    def arcane_edge_remove():
        scoreboard players reset @s genesis.passive.arcane_edge_statboost