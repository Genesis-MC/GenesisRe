from genesis:utils import texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from genesis:tungsten import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, Frostflake, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, FrozenWisp, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 
from genesis:item/dagger import HarbingerOfWinter

from genesis:status_impl import Frostbite, PolarVortex

# IronGreatsword
@add_custom_recipe([
    [None, "iron_ingot", None],
    ["iron_ingot", "iron_ingot", "iron_ingot"],
    [None, "stick", None],
])
class IronGreatsword(GenesisItem):
    item_name = ("Iron Greatsword", {"color":"white"})
    rarity = "common"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":120,"attack_speed":65})

# VerdantGreatsword
@add_custom_recipe([
    [None, VerdantTwig, None],
    [VerdantTwig, "iron_block", VerdantTwig],
    [None, SteelHilt, None],
])
class VerdantGreatsword(GenesisItem):
    item_name = ("Verdant Greatsword", {"color":"white"})
    rarity = "uncommon"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":125,"attack_speed":67,"health":40})
    passives = [{
        "name": "Lifeline",
        "description": "Gain Regeneration I.",
    }]

    @on_equip(slot = 'mainhand')
    def lifeline_add():
        tag @s add genesis.passive.lifeline

    @on_unequip(slot = 'mainhand')
    def lifeline_remove():
        tag @s remove genesis.passive.lifeline

# Zweihander
@add_custom_recipe([
    [None, MetalAlloy, None],
    [MetalAlloy, MetalAlloy, MetalAlloy],
    [None, SteelHilt, None],
])
class Zweihander(GenesisItem):
    item_name = ("Zweihander", {"color":"white"})
    rarity = "uncommon"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":120,"attack_speed":75})
    @right_click_ability(
        name = "Stance Swap - Onslaught",
        description = "Toggles Onslaught Stance. While Onslaught Stance is active, gain +40 Speed, +10% Attack Speed but -20 Armor, -20 Armor Toughness.",
        cooldown = 5,
    )
    def stance_swap_onslaught():
        say swapping stance #! TODO: Implement

# EverfrostTitanblade
@add_custom_recipe([
    [HarbingerOfWinter, EverfrostCore, HarbingerOfWinter],
    [HarbingerOfWinter, EverfrostCore, HarbingerOfWinter],
    [None, BejeweledHilt, None],
])
class EverfrostTitanblade(GenesisItem):
    item_name = ("Everfrost Titanblade", {"color":"aqua"})
    rarity = "legendary"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":150,"attack_speed":50,"mana_pool":20,"mana_regen":50,"speed":-50})
    @right_click_ability(
        name = "Polar Vortex",
        description = "Summon a localized blizzard which follows you around. While this ability is active, 10 mana will be consumed every 0.5 seconds and all enemies in a 6-block radius will be granted +1 Frostbite and Slowness I. This ability can be toggled on and off, and will automatically end if you run out of mana.",
        mana = 0,
        cooldown = 1,
    )
    def polar_vortex():
        if entity @s[tag=(PolarVortex.tag)] return run function ~/remove:
            PolarVortex.remove()
        PolarVortex.apply()

# SwashbucklersGlory
class SwashbucklersGlory(GenesisItem):
    item_name = ("Swashbucklers Glory", {"color":"blue"})
    rarity = "epic"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":140,"attack_speed":60,"armor_toughness":30})
    @right_click_ability(
        name = "Cleave II",
        description = "Slash all enemies in a 4-block radius, dealing 75% of your Physical Power.",
        cooldown = 8,
    )
    def cleave2():
        tag @s add genesis.caster 
        summon marker ~ ~1 ~ {Tags:["genesis.ability.cleave_particle"]}
        store result storage genesis:temp item.cleave.damage float 0.075 scoreboard players get @s genesis.stat.physical_power
        execute function ~/../cleave_macro with storage genesis:temp item.cleave:
            $execute as @e[distance=..4,tag=!genesis.player] run damage @s $(damage) minecraft:generic by @a[tag=genesis.caster,limit=1]
        tag @s remove genesis.caster
    
# RoyalCleaver
class RoyalCleaver(GenesisItem):
    item_name = ("Royal Cleaver", {"color":"gold"})
    rarity = "epic"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":150,"attack_speed":67,"armor":30,"knockback_resistance":30,"mana_regen":-100,"speed":-25})

# Exetol
class Exetol(GenesisItem):
    item_name = ("Exetol", {"color":"red"})
    rarity = "legendary"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":180,"attack_speed":67})