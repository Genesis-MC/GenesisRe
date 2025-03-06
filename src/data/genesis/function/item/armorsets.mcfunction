from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, BlizzardTear, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, HexedHailstone, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 

# SteelAndureHelmet
@add_custom_recipe([
    ["iron_ingot", "chain", "iron_ingot"],
    ["chain", "iron_helmet", "chain"],
    ["iron_ingot", "chain", "iron_ingot"],
])
@add_loot_table
class SteelAndureHelmet(metaclass=GenesisItem):
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
@add_loot_table
class SteelAndureChestplate(metaclass=GenesisItem):
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
@add_loot_table
class SteelAndureLeggings(metaclass=GenesisItem):
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
@add_loot_table
class SteelAndureBoots(metaclass=GenesisItem):
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
@add_loot_table
class ReinforcedandureHelmet(metaclass=GenesisItem):
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
@add_loot_table
class ReinforcedandureChestplate(metaclass=GenesisItem):
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
@add_loot_table
class ReinforcedandureLeggings(metaclass=GenesisItem):
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
@add_loot_table
class ReinforcedandureBoots(metaclass=GenesisItem):
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
@add_loot_table
class ApprenticeHat(metaclass=GenesisItem):
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
@add_loot_table
class ApprenticeRobe(metaclass=GenesisItem):
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
@add_loot_table
class ApprenticeTrousers(metaclass=GenesisItem):
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
@add_loot_table
class ApprenticeBoots(metaclass=GenesisItem):
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
@add_loot_table
class MageHat(metaclass=GenesisItem):
    item_name = ("Mage Hat", {"color":"blue"})
    rarity = "rare"
    category = ["helmet"]
    stats = ("head", {"magic_power":10,"armor":25,"mana_pool":20,"mana_regen":4})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# MageRobe
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeRobe, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])
@add_loot_table
class MageRobe(metaclass=GenesisItem):
    item_name = ("Mage Robe", {"color":"blue"})
    rarity = "rare"
    category = ["chestplate"]
    stats = ("chest", {"magic_power":15,"armor":60,"mana_pool":30,"mana_regen":5})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# MageTrousers
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeTrousers, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])
@add_loot_table
class MageTrousers(metaclass=GenesisItem):
    item_name = ("Mage Trousers", {"color":"blue"})
    rarity = "rare"
    category = ["leggings"]
    stats = ("legs", {"magic_power":15,"armor":50,"mana_pool":30,"mana_regen":5})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# MageBoots
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeBoots, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])
@add_loot_table
class MageBoots(metaclass=GenesisItem):
    item_name = ("Mage Boots", {"color":"blue"})
    rarity = "rare"
    category = ["boots"]
    stats = ("feet", {"magic_power":10,"armor":25,"mana_pool":20,"mana_regen":4})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# ArchmageHat
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageHat, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])
@add_loot_table
class ArchmageHat(metaclass=GenesisItem):
    item_name = ("Archmage Hat", {"color":"dark_purple"})
    rarity = "epic"
    category = ["helmet"]
    stats = ("head", {"magic_power":15,"armor":30,"mana_pool":40,"mana_regen":5})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# ArchmageRobe
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageRobe, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])
@add_loot_table
class ArchmageRobe(metaclass=GenesisItem):
    item_name = ("Archmage Robe", {"color":"dark_purple"})
    rarity = "epic"
    category = ["chestplate"]
    stats = ("chest", {"magic_power":25,"armor":70,"mana_pool":50,"mana_regen":8})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# ArchmageTrousers
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageTrousers, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])
@add_loot_table
class ArchmageTrousers(metaclass=GenesisItem):
    item_name = ("Archmage Trousers", {"color":"dark_purple"})
    rarity = "epic"
    category = ["leggings"]
    stats = ("legs", {"magic_power":25,"armor":60,"mana_pool":50,"mana_regen":8})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# ArchmageBoots
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageBoots, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])
@add_loot_table
class ArchmageBoots(metaclass=GenesisItem):
    item_name = ("Archmage Boots", {"color":"dark_purple"})
    rarity = "epic"
    category = ["boots"]
    stats = ("feet", {"magic_power":15,"armor":30,"mana_pool":40,"mana_regen":5})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# FrostveilHelmet
@add_loot_table
class FrostveilHelmet(metaclass=GenesisItem):
    item_name = ("Frostveil Helmet", {"color":"aqua"})
    rarity = "uncommon"
    category = ["helmet"]
    stats = ("head", {"armor":20})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# FrostveilChestplate
@add_loot_table
class FrostveilChestplate(metaclass=GenesisItem):
    item_name = ("Frostveil Chestplate", {"color":"aqua"})
    rarity = "uncommon"
    category = ["chestplate"]
    stats = ("chest", {"armor":70})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# FrostveilLeggings
@add_loot_table
class FrostveilLeggings(metaclass=GenesisItem):
    item_name = ("Frostveil Leggings", {"color":"aqua"})
    rarity = "uncommon"
    category = ["leggings"]
    stats = ("legs", {"armor":50})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# FrostveilBoots
@add_loot_table
class FrostveilBoots(metaclass=GenesisItem):
    item_name = ("Frostveil Boots", {"color":"aqua"})
    rarity = "uncommon"
    category = ["boots"]
    stats = ("feet", {"armor":20})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# ShadedHelmet
@add_loot_table
class ShadedHelmet(metaclass=GenesisItem):
    item_name = ("Shaded Helmet", {"color":"dark_purple"})
    rarity = "rare"
    category = ["helmet"]
    stats = ("head", {"physical_power":5,"armor":20})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# ShadedChestplate
@add_loot_table
class ShadedChestplate(metaclass=GenesisItem):
    item_name = ("Shaded Chestplate", {"color":"dark_purple"})
    rarity = "rare"
    category = ["chestplate"]
    stats = ("chest", {"physical_power":5,"armor":70})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# ShadedLeggings
@add_loot_table
class ShadedLeggings(metaclass=GenesisItem):
    item_name = ("Shaded Leggings", {"color":"dark_purple"})
    rarity = "rare"
    category = ["leggings"]
    stats = ("legs", {"physical_power":5,"armor":50})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# ShadedBoots
@add_loot_table
class ShadedBoots(metaclass=GenesisItem):
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
@add_loot_table
class VoidbreachHelmet(metaclass=GenesisItem):
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
@add_loot_table
class VoidbreachChestplate(metaclass=GenesisItem):
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
@add_loot_table
class VoidbreachLeggings(metaclass=GenesisItem):
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
@add_loot_table
class VoidbreachBoots(metaclass=GenesisItem):
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
@add_loot_table
class DreadnaughtHelmet(metaclass=GenesisItem):
    item_name = ("Dreadnaught Helmet", {"color":"dark_red"})
    rarity = "legendary"
    category = ["helmet"]
    stats = ("head", {"attack_speed":-4,"armor":40,"armor_toughness":40,"speed":-5})
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# DreadnaughtChestplate
@add_custom_recipe([
    ["netherite_scrap", None, "netherite_scrap"],
    [MetalAlloy, PyroclasticCore, MetalAlloy],
    [MetalAlloy, MetalAlloy, MetalAlloy],
])
@add_loot_table
class DreadnaughtChestplate(metaclass=GenesisItem):
    item_name = ("Dreadnaught Chestplate", {"color":"dark_red"})
    rarity = "legendary"
    category = ["chestplate"]
    stats = ("chest", {"attack_speed":-5,"armor":90,"armor_toughness":40,"speed":-6})
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# DreadnaughtLeggings
@add_custom_recipe([
    [MetalAlloy, PyroclasticCore, MetalAlloy],
    [MetalAlloy, None, MetalAlloy],
    ["netherite_scrap", None, "netherite_scrap"],
])
@add_loot_table
class DreadnaughtLeggings(metaclass=GenesisItem):
    item_name = ("Dreadnaught Leggings", {"color":"dark_red"})
    rarity = "legendary"
    category = ["leggings"]
    stats = ("legs", {"attack_speed":-5,"armor":70,"armor_toughness":40,"speed":-6})
    equippable = {"slot":"legs","asset_id":"minecraft:diamond"}

# DreadnaughtBoots
@add_custom_recipe([
    [None, "netherite_scrap", None],
    [MetalAlloy, None, MetalAlloy],
    [MetalAlloy, PyroclasticCore, MetalAlloy],
])
@add_loot_table
class DreadnaughtBoots(metaclass=GenesisItem):
    item_name = ("Dreadnaught Boots", {"color":"dark_red"})
    rarity = "legendary"
    category = ["boots"]
    stats = ("feet", {"attack_speed":-4,"armor":40,"armor_toughness":40,"speed":-5})
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}