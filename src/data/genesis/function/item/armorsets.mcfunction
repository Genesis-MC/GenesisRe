from genesis:utils import texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from genesis:tungsten import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, Frostflake, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, FrozenWisp, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 
from genesis:status_impl import SharedMind

# SteelAndureHelmet
@add_custom_recipe([
    ["iron_ingot", "chain", "iron_ingot"],
    ["chain", "iron_helmet", "chain"],
    ["iron_ingot", "chain", "iron_ingot"],
])
class SteelAndureHelmet(GenesisItem):
    item_name = ("Steel Andure Helmet", {"color":"white"})
    rarity = "common"
    category = ["helmet"]
    stats = ("head", {"armor":25})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# SteelAndureChestplate
@add_custom_recipe([
    ["iron_ingot", "chain", "iron_ingot"],
    ["chain", "iron_chestplate", "chain"],
    ["iron_ingot", "chain", "iron_ingot"],
])
class SteelAndureChestplate(GenesisItem):
    item_name = ("Steel Andure Chestplate", {"color":"white"})
    rarity = "common"
    category = ["chestplate"]
    stats = ("chest", {"armor":65})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# SteelAndureLeggings
@add_custom_recipe([
    ["iron_ingot", "chain", "iron_ingot"],
    ["chain", "iron_leggings", "chain"],
    ["iron_ingot", "chain", "iron_ingot"],
])
class SteelAndureLeggings(GenesisItem):
    item_name = ("Steel Andure Leggings", {"color":"white"})
    rarity = "common"
    category = ["leggings"]
    stats = ("legs", {"armor":55})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# SteelAndureBoots
@add_custom_recipe([
    ["iron_ingot", "chain", "iron_ingot"],
    ["chain", "iron_boots", "chain"],
    ["iron_ingot", "chain", "iron_ingot"],
])
class SteelAndureBoots(GenesisItem):
    item_name = ("Steel Andure Boots", {"color":"white"})
    rarity = "common"
    category = ["boots"]
    stats = ("feet", {"armor":25})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# ReinforcedandureHelmet
@add_custom_recipe([
    ["chain", "chain", "chain"],
    [MetalAlloy, SteelAndureHelmet, MetalAlloy],
    ["chain", "chain", "chain"],
])
class ReinforcedandureHelmet(GenesisItem):
    item_name = ("Reinforcedandure Helmet", {"color":"white"})
    rarity = "uncommon"
    category = ["helmet"]
    stats = ("head", {"armor":30,"armor_toughness":20})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# ReinforcedandureChestplate
@add_custom_recipe([
    ["chain", "chain", "chain"],
    [MetalAlloy, SteelAndureChestplate, MetalAlloy],
    ["chain", "chain", "chain"],
])
class ReinforcedandureChestplate(GenesisItem):
    item_name = ("Reinforcedandure Chestplate", {"color":"white"})
    rarity = "uncommon"
    category = ["chestplate"]
    stats = ("chest", {"armor":70,"armor_toughness":20})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# ReinforcedandureLeggings
@add_custom_recipe([
    ["chain", "chain", "chain"],
    [MetalAlloy, SteelAndureLeggings, MetalAlloy],
    ["chain", "chain", "chain"],
])
class ReinforcedandureLeggings(GenesisItem):
    item_name = ("Reinforcedandure Leggings", {"color":"white"})
    rarity = "uncommon"
    category = ["leggings"]
    stats = ("legs", {"armor":60,"armor_toughness":20})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# ReinforcedandureBoots
@add_custom_recipe([
    ["chain", "chain", "chain"],
    [MetalAlloy, SteelAndureBoots, MetalAlloy],
    ["chain", "chain", "chain"],
])
class ReinforcedandureBoots(GenesisItem):
    item_name = ("Reinforcedandure Boots", {"color":"white"})
    rarity = "uncommon"
    category = ["boots"]
    stats = ("feet", {"armor":30,"armor_toughness":20})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# ApprenticeHat
@add_custom_recipe([
    [Cloth, ManaCloth, Cloth],
    [Cloth, "leather_helmet", Cloth],
    [Cloth, ManaCloth, Cloth],
])
class ApprenticeHat(GenesisItem):
    item_name = ("Apprentice Hat", {"color":"white"})
    rarity = "uncommon"
    category = ["helmet"]
    stats = ("head", {"armor":10,"mana_pool":10})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# ApprenticeRobe
@add_custom_recipe([
    [Cloth, ManaCloth, Cloth],
    [Cloth, "leather_chestplate", Cloth],
    [Cloth, ManaCloth, Cloth],
])
class ApprenticeRobe(GenesisItem):
    item_name = ("Apprentice Robe", {"color":"white"})
    rarity = "uncommon"
    category = ["chestplate"]
    stats = ("chest", {"armor":30,"mana_pool":20})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# ApprenticeTrousers
@add_custom_recipe([
    [Cloth, ManaCloth, Cloth],
    [Cloth, "leather_leggings", Cloth],
    [Cloth, ManaCloth, Cloth],
])
class ApprenticeTrousers(GenesisItem):
    item_name = ("Apprentice Trousers", {"color":"white"})
    rarity = "uncommon"
    category = ["leggings"]
    stats = ("legs", {"armor":20,"mana_pool":20})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# ApprenticeBoots
@add_custom_recipe([
    [Cloth, ManaCloth, Cloth],
    [Cloth, "leather_boots", Cloth],
    [Cloth, ManaCloth, Cloth],
])
class ApprenticeBoots(GenesisItem):
    item_name = ("Apprentice Boots", {"color":"white"})
    rarity = "uncommon"
    category = ["boots"]
    stats = ("feet", {"armor":10,"mana_pool":10})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# MageHat
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeHat, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])
class MageHat(GenesisItem):
    item_name = ("Mage Hat", {"color":"blue"})
    rarity = "rare"
    category = ["helmet"]
    stats = ("head", {"magic_power":10,"armor":25,"mana_pool":20,"mana_regen":40})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# MageRobe
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeRobe, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])
class MageRobe(GenesisItem):
    item_name = ("Mage Robe", {"color":"blue"})
    rarity = "rare"
    category = ["chestplate"]
    stats = ("chest", {"magic_power":15,"armor":60,"mana_pool":30,"mana_regen":50})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# MageTrousers
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeTrousers, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])
class MageTrousers(GenesisItem):
    item_name = ("Mage Trousers", {"color":"blue"})
    rarity = "rare"
    category = ["leggings"]
    stats = ("legs", {"magic_power":15,"armor":50,"mana_pool":30,"mana_regen":50})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# MageBoots
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeBoots, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])
class MageBoots(GenesisItem):
    item_name = ("Mage Boots", {"color":"blue"})
    rarity = "rare"
    category = ["boots"]
    stats = ("feet", {"magic_power":10,"armor":25,"mana_pool":20,"mana_regen":40})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# ArchmageHat
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageHat, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])
class ArchmageHat(GenesisItem):
    item_name = ("Archmage Hat", {"color":"dark_purple"})
    rarity = "epic"
    category = ["helmet"]
    stats = ("head", {"magic_power":15,"armor":30,"mana_pool":40,"mana_regen":50})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# ArchmageRobe
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageRobe, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])
class ArchmageRobe(GenesisItem):
    item_name = ("Archmage Robe", {"color":"dark_purple"})
    rarity = "epic"
    category = ["chestplate"]
    stats = ("chest", {"magic_power":25,"armor":70,"mana_pool":50,"mana_regen":80})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# ArchmageTrousers
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageTrousers, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])
class ArchmageTrousers(GenesisItem):
    item_name = ("Archmage Trousers", {"color":"dark_purple"})
    rarity = "epic"
    category = ["leggings"]
    stats = ("legs", {"magic_power":25,"armor":60,"mana_pool":50,"mana_regen":80})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# ArchmageBoots
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageBoots, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])
class ArchmageBoots(GenesisItem):
    item_name = ("Archmage Boots", {"color":"dark_purple"})
    rarity = "epic"
    category = ["boots"]
    stats = ("feet", {"magic_power":15,"armor":30,"mana_pool":40,"mana_regen":50})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# FrostveilHelmet
class FrostveilHelmet(GenesisItem):
    item_name = ("Frostveil Helmet", {"color":"aqua"})
    rarity = "uncommon"
    category = ["helmet"]
    stats = ("head", {"armor":20})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# FrostveilChestplate
class FrostveilChestplate(GenesisItem):
    item_name = ("Frostveil Chestplate", {"color":"aqua"})
    rarity = "uncommon"
    category = ["chestplate"]
    stats = ("chest", {"armor":70})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# FrostveilLeggings
class FrostveilLeggings(GenesisItem):
    item_name = ("Frostveil Leggings", {"color":"aqua"})
    rarity = "uncommon"
    category = ["leggings"]
    stats = ("legs", {"armor":50})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# FrostveilBoots
class FrostveilBoots(GenesisItem):
    item_name = ("Frostveil Boots", {"color":"aqua"})
    rarity = "uncommon"
    category = ["boots"]
    stats = ("feet", {"armor":20})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# ShadedHelmet
class ShadedHelmet(GenesisItem):
    item_name = ("Shaded Helmet", {"color":"dark_purple"})
    rarity = "rare"
    category = ["helmet"]
    stats = ("head", {"physical_power":5,"armor":20})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# ShadedChestplate
class ShadedChestplate(GenesisItem):
    item_name = ("Shaded Chestplate", {"color":"dark_purple"})
    rarity = "rare"
    category = ["chestplate"]
    stats = ("chest", {"physical_power":5,"armor":70})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# ShadedLeggings
class ShadedLeggings(GenesisItem):
    item_name = ("Shaded Leggings", {"color":"dark_purple"})
    rarity = "rare"
    category = ["leggings"]
    stats = ("legs", {"physical_power":5,"armor":50})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# ShadedBoots
class ShadedBoots(GenesisItem):
    item_name = ("Shaded Boots", {"color":"dark_purple"})
    rarity = "rare"
    category = ["boots"]
    stats = ("feet", {"physical_power":5,"armor":20})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# VoidbreachHelmet
@add_custom_recipe([
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
    [VoidedFragment, ShadedHelmet, VoidedFragment],
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
])
class VoidbreachHelmet(GenesisItem):
    item_name = ("Voidbreach Helmet", {"color":"light_purple"})
    rarity = "epic"
    category = ["void","helmet"]
    stats = ("head", {"physical_power":5,"armor":30})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# VoidbreachChestplate
@add_custom_recipe([
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
    [VoidedFragment, ShadedChestplate, VoidedFragment],
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
])
class VoidbreachChestplate(GenesisItem):
    item_name = ("Voidbreach Chestplate", {"color":"light_purple"})
    rarity = "epic"
    category = ["void","chestplate"]
    stats = ("chest", {"physical_power":5,"armor":75})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# VoidbreachLeggings
@add_custom_recipe([
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
    [VoidedFragment, ShadedLeggings, VoidedFragment],
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
])
class VoidbreachLeggings(GenesisItem):
    item_name = ("Voidbreach Leggings", {"color":"light_purple"})
    rarity = "epic"
    category = ["void","leggings"]
    stats = ("legs", {"physical_power":5,"armor":55})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# VoidbreachBoots
@add_custom_recipe([
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
    [VoidedFragment, ShadedBoots, VoidedFragment],
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
])
class VoidbreachBoots(GenesisItem):
    item_name = ("Voidbreach Boots", {"color":"light_purple"})
    rarity = "epic"
    category = ["void","boots"]
    stats = ("feet", {"physical_power":5,"armor":30})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# DreadnaughtHelmet
@add_custom_recipe([
    [MetalAlloy, PyroclasticCore, MetalAlloy],
    [MetalAlloy, None, MetalAlloy],
    [None, "netherite_scrap", None],
])
class DreadnaughtHelmet(GenesisItem):
    item_name = ("Dreadnaught Helmet", {"color":"dark_red"})
    rarity = "legendary"
    category = ["helmet"]
    stats = ("head", {"attack_speed":-7,"armor":40,"armor_toughness":40,"speed":-5})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# DreadnaughtChestplate
@add_custom_recipe([
    ["netherite_scrap", None, "netherite_scrap"],
    [MetalAlloy, PyroclasticCore, MetalAlloy],
    [MetalAlloy, MetalAlloy, MetalAlloy],
])
class DreadnaughtChestplate(GenesisItem):
    item_name = ("Dreadnaught Chestplate", {"color":"dark_red"})
    rarity = "legendary"
    category = ["chestplate"]
    stats = ("chest", {"attack_speed":-8,"armor":90,"armor_toughness":40,"speed":-6})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# DreadnaughtLeggings
@add_custom_recipe([
    [MetalAlloy, PyroclasticCore, MetalAlloy],
    [MetalAlloy, None, MetalAlloy],
    ["netherite_scrap", None, "netherite_scrap"],
])
class DreadnaughtLeggings(GenesisItem):
    item_name = ("Dreadnaught Leggings", {"color":"dark_red"})
    rarity = "legendary"
    category = ["leggings"]
    stats = ("legs", {"attack_speed":-8,"armor":70,"armor_toughness":40,"speed":-6})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# DreadnaughtBoots
@add_custom_recipe([
    [None, "netherite_scrap", None],
    [MetalAlloy, None, MetalAlloy],
    [MetalAlloy, PyroclasticCore, MetalAlloy],
])
class DreadnaughtBoots(GenesisItem):
    item_name = ("Dreadnaught Boots", {"color":"dark_red"})
    rarity = "legendary"
    category = ["boots"]
    stats = ("feet", {"attack_speed":-7,"armor":40,"armor_toughness":40,"speed":-5})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# SymbioticHelmet
class SymbioticHelmet(GenesisItem):
    item_name = ("Symbiotic Mind", {"color":"dark_purple"})
    rarity = "epic"
    category = ['symbiotic', None, "helmet"]
    stats = ("head", {"armor":10,"mana_regen":10})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}
    passives = [{
        "name": "Shared Mind",
        "description": "When you take damage, gain hugely increased Mana Regeneration for a short time. This effect gets stronger the more Symbiotic items you have equipped.",
    }]

    @on_attacked(full_slot = 'armor.head')
    def shared_mind():
        anchored eyes particle portal ^ ^ ^ 0 0 0 1 20
        SharedMind.apply_standard()

# SymbioticChestplate
class SymbioticChestplate(GenesisItem):
    item_name = ("Symbiotic Chestplate", {"color":"dark_purple"})
    rarity = "epic"
    category = ['symbiotic', None, "chestplate"]
    stats = ("chest", {"armor":35})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# SymbioticLeggings
class SymbioticLeggings(GenesisItem):
    item_name = ("Symbiotic Leggings", {"color":"dark_purple"})
    rarity = "epic"
    category = ['symbiotic', None, "leggings"]
    stats = ("legs", {"armor":25})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# SymbioticBoots
class SymbioticBoots(GenesisItem):
    item_name = ("Symbiotic Boots", {"color":"dark_purple"})
    rarity = "epic"
    category = ['symbiotic', None, "boots"]
    stats = ("feet", {"armor":10})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}