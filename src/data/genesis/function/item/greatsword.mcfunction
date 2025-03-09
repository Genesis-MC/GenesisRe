from genesis:utils import texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, BlizzardTear, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, HexedHailstone, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 
from genesis:item/dagger import HarbingerOfWinter

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
    stats = ("mainhand", {"physical_power":110,"attack_speed":38})

# OvergrownGreatsword
@add_custom_recipe([
    [None, VerdantTwig, None],
    [VerdantTwig, "iron_block", VerdantTwig],
    [None, SteelHilt, None],
])
class OvergrownGreatsword(GenesisItem):
    item_name = ("OvergrownGreatsword", {"color":"green"})
    rarity = "uncommon"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":125,"attack_speed":40,"health":40})

# Zweihander
@add_custom_recipe([
    [None, MetalAlloy, None],
    [MetalAlloy, MetalAlloy, MetalAlloy],
    [None, SteelHilt, None],
])
class Zweihander(GenesisItem):
    item_name = ("Zweihander", {"color":"white"})
    rarity = "rare"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":120,"attack_speed":45})
    item_model = "iron_sword" #! change to custom texture
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
    stats = ("mainhand", {"physical_power":150,"attack_speed":30,"mana_pool":20,"mana_regen":50,"speed":-50})
    @right_click_ability(
        name = "polar_vortex",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def polar_vortex():
        say WIP

# SwashbucklersGlory
class SwashbucklersGlory(GenesisItem):
    item_name = ("Swashbucklers Glory", {"color":"blue"})
    rarity = "epic"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":140,"attack_speed":35,"armor_toughness":30})
    @right_click_ability(
        name = "cleave2",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def cleave2():
        say WIP
    
# RoyalCleaver
class RoyalCleaver(GenesisItem):
    item_name = ("Royal Cleaver", {"color":"gold"})
    rarity = "epic"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":150,"attack_speed":40,"armor":30,"knockback_resistance":30,"mana_regen":-100,"speed":-25})

# Exetol
class Exetol(GenesisItem):
    item_name = ("Exetol", {"color":"red"})
    rarity = "legendary"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":150,"attack_speed":40})