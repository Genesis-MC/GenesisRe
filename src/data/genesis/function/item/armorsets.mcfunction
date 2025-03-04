from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

# SteelandureHelmet
@add_custom_recipe([
    ["iron_ingot", "chain", "iron_ingot"],
    ["chain", "iron_helmet", "chain"],
    ["iron_ingot", "chain", "iron_ingot"],
])
@add_loot_table
@bolt_item
class SteelandureHelmet(GenesisItem):
    item_name = ("Steelandure Helmet", {"color":"white"})
    rarity = "common"
    category = ["helmet"]
    stats = ("head", {"armor":25})
    item_model = texture_path_to_item_model("genesis:item/armorsets/steelandurehelmet", True)
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# SteelandureChestplate
@add_custom_recipe([
    ["iron_ingot", "chain", "iron_ingot"],
    ["chain", "iron_chestplate", "chain"],
    ["iron_ingot", "chain", "iron_ingot"],
])
@add_loot_table
@bolt_item
class SteelandureChestplate(GenesisItem):
    item_name = ("Steelandure Chestplate", {"color":"white"})
    rarity = "common"
    category = ["chestplate"]
    stats = ("chest", {"armor":65})
    item_model = texture_path_to_item_model("genesis:item/armorsets/steelandurechestplate", True)
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# SteelandureLeggings
@add_custom_recipe([
    ["iron_ingot", "chain", "iron_ingot"],
    ["chain", "iron_leggings", "chain"],
    ["iron_ingot", "chain", "iron_ingot"],
])
@add_loot_table
@bolt_item
class SteelandureLeggings(GenesisItem):
    item_name = ("Steelandure Leggings", {"color":"white"})
    rarity = "common"
    category = ["leggings"]
    stats = ("leg", {"armor":55})
    item_model = texture_path_to_item_model("genesis:item/armorsets/steelandureleggings", True)
    equippable = {"slot":"leg","asset_id":"minecraft:diamond"}

# SteelandureBoots
@add_custom_recipe([
    ["iron_ingot", "chain", "iron_ingot"],
    ["chain", "iron_boots", "chain"],
    ["iron_ingot", "chain", "iron_ingot"],
])
@add_loot_table
@bolt_item
class SteelandureBoots(GenesisItem):
    item_name = ("Steelandure Boots", {"color":"white"})
    rarity = "common"
    category = ["boots"]
    stats = ("feet", {"armor":25})
    item_model = texture_path_to_item_model("genesis:item/armorsets/steelandureboots", True)
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# ReinforcedandureHelmet
@add_custom_recipe([
    ["chain", "chain", "chain"],
    [MetalAlloy, SteelAndureHelmet, MetalAlloy],
    ["chain", "chain", "chain"],
])
@add_loot_table
@bolt_item
class ReinforcedandureHelmet(GenesisItem):
    item_name = ("Reinforcedandure Helmet", {"color":"white"})
    rarity = "uncommon"
    category = ["helmet"]
    stats = ("head", {"armor":30,"armor_toughness":20})
    item_model = texture_path_to_item_model("genesis:item/armorsets/reinforcedandurehelmet", True)
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# ReinforcedandureChestplate
@add_custom_recipe([
    ["chain", "chain", "chain"],
    [MetalAlloy, SteelAndureChestplate, MetalAlloy],
    ["chain", "chain", "chain"],
])
@add_loot_table
@bolt_item
class ReinforcedandureChestplate(GenesisItem):
    item_name = ("Reinforcedandure Chestplate", {"color":"white"})
    rarity = "uncommon"
    category = ["chestplate"]
    stats = ("chest", {"armor":70,"armor_toughness":20})
    item_model = texture_path_to_item_model("genesis:item/armorsets/reinforcedandurechestplate", True)
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# ReinforcedandureLeggings
@add_custom_recipe([
    ["chain", "chain", "chain"],
    [MetalAlloy, SteelAndureLeggings, MetalAlloy],
    ["chain", "chain", "chain"],
])
@add_loot_table
@bolt_item
class ReinforcedandureLeggings(GenesisItem):
    item_name = ("Reinforcedandure Leggings", {"color":"white"})
    rarity = "uncommon"
    category = ["leggings"]
    stats = ("leg", {"armor":60,"armor_toughness":20})
    item_model = texture_path_to_item_model("genesis:item/armorsets/reinforcedandureleggings", True)
    equippable = {"slot":"leg","asset_id":"minecraft:diamond"}

# ReinforcedandureBoots
@add_custom_recipe([
    ["chain", "chain", "chain"],
    [MetalAlloy, SteelAndureBoots, MetalAlloy],
    ["chain", "chain", "chain"],
])
@add_loot_table
@bolt_item
class ReinforcedandureBoots(GenesisItem):
    item_name = ("Reinforcedandure Boots", {"color":"white"})
    rarity = "uncommon"
    category = ["boots"]
    stats = ("feet", {"armor":30,"armor_toughness":20})
    item_model = texture_path_to_item_model("genesis:item/armorsets/reinforcedandureboots", True)
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# ApprenticeHat
@add_custom_recipe([
    [Cloth, ManaCloth, Cloth],
    [Cloth, "leather_helmet", Cloth],
    [Cloth, ManaCloth, Cloth],
])
@add_loot_table
@bolt_item
class ApprenticeHat(GenesisItem):
    item_name = ("Apprentice Hat", {"color":"white"})
    rarity = "uncommon"
    category = ["helmet"]
    stats = ("head", {"armor":10,"mana_pool":10})
    item_model = texture_path_to_item_model("genesis:item/armorsets/apprentice_hat", True)
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# ApprenticeRobe
@add_custom_recipe([
    [Cloth, ManaCloth, Cloth],
    [Cloth, "leather_chestplate", Cloth],
    [Cloth, ManaCloth, Cloth],
])
@add_loot_table
@bolt_item
class ApprenticeRobe(GenesisItem):
    item_name = ("Apprentice Robe", {"color":"white"})
    rarity = "uncommon"
    category = ["chestplate"]
    stats = ("chest", {"armor":30,"mana_pool":20})
    item_model = texture_path_to_item_model("genesis:item/armorsets/apprentice_robe", True)
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# ApprenticeTrousers
@add_custom_recipe([
    [Cloth, ManaCloth, Cloth],
    [Cloth, "leather_leggings", Cloth],
    [Cloth, ManaCloth, Cloth],
])
@add_loot_table
@bolt_item
class ApprenticeTrousers(GenesisItem):
    item_name = ("Apprentice Trousers", {"color":"white"})
    rarity = "uncommon"
    category = ["leggings"]
    stats = ("leg", {"armor":20,"mana_pool":20})
    item_model = texture_path_to_item_model("genesis:item/armorsets/apprentice_trousers", True)
    equippable = {"slot":"leg","asset_id":"minecraft:diamond"}

# ApprenticeBoots
@add_custom_recipe([
    [Cloth, ManaCloth, Cloth],
    [Cloth, "leather_boots", Cloth],
    [Cloth, ManaCloth, Cloth],
])
@add_loot_table
@bolt_item
class ApprenticeBoots(GenesisItem):
    item_name = ("Apprentice Boots", {"color":"white"})
    rarity = "uncommon"
    category = ["boots"]
    stats = ("feet", {"armor":10,"mana_pool":10})
    item_model = texture_path_to_item_model("genesis:item/armorsets/apprentice_boots", True)
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# MageHat
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeHat, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])
@add_loot_table
@bolt_item
class MageHat(GenesisItem):
    item_name = ("Mage Hat", {"color":"blue"})
    rarity = "rare"
    category = ["helmet"]
    stats = ("head", {"magic_power":10,"armor":25,"mana_pool":20,"mana_regen":4})
    item_model = texture_path_to_item_model("genesis:item/armorsets/mage_hat", True)
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# MageRobe
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeRobe, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])
@add_loot_table
@bolt_item
class MageRobe(GenesisItem):
    item_name = ("Mage Robe", {"color":"blue"})
    rarity = "rare"
    category = ["chestplate"]
    stats = ("chest", {"magic_power":15,"armor":60,"mana_pool":30,"mana_regen":5})
    item_model = texture_path_to_item_model("genesis:item/armorsets/mage_robe", True)
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# MageTrousers
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeTrousers, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])
@add_loot_table
@bolt_item
class MageTrousers(GenesisItem):
    item_name = ("Mage Trousers", {"color":"blue"})
    rarity = "rare"
    category = ["leggings"]
    stats = ("leg", {"magic_power":15,"armor":50,"mana_pool":30,"mana_regen":5})
    item_model = texture_path_to_item_model("genesis:item/armorsets/mage_trousers", True)
    equippable = {"slot":"leg","asset_id":"minecraft:diamond"}

# MageBoots
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeBoots, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])
@add_loot_table
@bolt_item
class MageBoots(GenesisItem):
    item_name = ("Mage Boots", {"color":"blue"})
    rarity = "rare"
    category = ["boots"]
    stats = ("feet", {"magic_power":10,"armor":25,"mana_pool":20,"mana_regen":4})
    item_model = texture_path_to_item_model("genesis:item/armorsets/mage_boots", True)
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# ArchmageHat
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageHat, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])
@add_loot_table
@bolt_item
class ArchmageHat(GenesisItem):
    item_name = ("Archmage Hat", {"color":"dark_purple"})
    rarity = "epic"
    category = ["helmet"]
    stats = ("head", {"magic_power":15,"armor":30,"mana_pool":40,"mana_regen":5})
    item_model = texture_path_to_item_model("genesis:item/armorsets/archmage_hat", True)
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# ArchmageRobe
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageRobe, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])
@add_loot_table
@bolt_item
class ArchmageRobe(GenesisItem):
    item_name = ("Archmage Robe", {"color":"dark_purple"})
    rarity = "epic"
    category = ["chestplate"]
    stats = ("chest", {"magic_power":25,"armor":70,"mana_pool":50,"mana_regen":8})
    item_model = texture_path_to_item_model("genesis:item/armorsets/archmage_robe", True)
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# ArchmageTrousers
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageTrousers, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])
@add_loot_table
@bolt_item
class ArchmageTrousers(GenesisItem):
    item_name = ("Archmage Trousers", {"color":"dark_purple"})
    rarity = "epic"
    category = ["leggings"]
    stats = ("leg", {"magic_power":25,"armor":60,"mana_pool":50,"mana_regen":8})
    item_model = texture_path_to_item_model("genesis:item/armorsets/archmage_trousers", True)
    equippable = {"slot":"leg","asset_id":"minecraft:diamond"}

# ArchmageBoots
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageBoots, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])
@add_loot_table
@bolt_item
class ArchmageBoots(GenesisItem):
    item_name = ("Archmage Boots", {"color":"dark_purple"})
    rarity = "epic"
    category = ["boots"]
    stats = ("feet", {"magic_power":15,"armor":30,"mana_pool":40,"mana_regen":5})
    item_model = texture_path_to_item_model("genesis:item/armorsets/archmage_boots", True)
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# FrostveilHelmet
@add_loot_table
@bolt_item
class FrostveilHelmet(GenesisItem):
    item_name = ("Frostveil Helmet", {"color":"aqua"})
    rarity = "uncommon"
    category = ["helmet"]
    stats = ("head", {"armor":20,"relic_power":5})
    item_model = texture_path_to_item_model("genesis:item/armorsets/frostveil_helmet", True)
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# FrostveilChestplate
@add_loot_table
@bolt_item
class FrostveilChestplate(GenesisItem):
    item_name = ("Frostveil Chestplate", {"color":"aqua"})
    rarity = "uncommon"
    category = ["chestplate"]
    stats = ("chest", {"armor":70,"relic_power":10})
    item_model = texture_path_to_item_model("genesis:item/armorsets/frostveil_chestplate", True)
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# FrostveilLeggings
@add_loot_table
@bolt_item
class FrostveilLeggings(GenesisItem):
    item_name = ("Frostveil Leggings", {"color":"aqua"})
    rarity = "uncommon"
    category = ["leggings"]
    stats = ("leg", {"armor":50,"relic_power":10})
    item_model = texture_path_to_item_model("genesis:item/armorsets/frostveil_leggings", True)
    equippable = {"slot":"leg","asset_id":"minecraft:diamond"}

# FrostveilBoots
@add_loot_table
@bolt_item
class FrostveilBoots(GenesisItem):
    item_name = ("Frostveil Boots", {"color":"aqua"})
    rarity = "uncommon"
    category = ["boots"]
    stats = ("feet", {"armor":20,"relic_power":5})
    item_model = texture_path_to_item_model("genesis:item/armorsets/frostveil_boots", True)
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# ShadedHelmet
@add_loot_table
@bolt_item
class ShadedHelmet(GenesisItem):
    item_name = ("Shaded Helmet", {"color":"dark_purple"})
    rarity = "rare"
    category = ["helmet"]
    stats = ("head", {"physical_power":5,"armor":20,"relic_power":15})
    item_model = texture_path_to_item_model("genesis:item/armorsets/shaded_helmet", True)
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# ShadedChestplate
@add_loot_table
@bolt_item
class ShadedChestplate(GenesisItem):
    item_name = ("Shaded Chestplate", {"color":"dark_purple"})
    rarity = "rare"
    category = ["chestplate"]
    stats = ("chest", {"physical_power":5,"armor":70,"relic_power":20})
    item_model = texture_path_to_item_model("genesis:item/armorsets/shaded_chestplate", True)
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# ShadedLeggings
@add_loot_table
@bolt_item
class ShadedLeggings(GenesisItem):
    item_name = ("Shaded Leggings", {"color":"dark_purple"})
    rarity = "rare"
    category = ["leggings"]
    stats = ("leg", {"physical_power":5,"armor":50,"relic_power":20})
    item_model = texture_path_to_item_model("genesis:item/armorsets/shaded_leggings", True)
    equippable = {"slot":"leg","asset_id":"minecraft:diamond"}

# ShadedBoots
@add_loot_table
@bolt_item
class ShadedBoots(GenesisItem):
    item_name = ("Shaded Boots", {"color":"dark_purple"})
    rarity = "rare"
    category = ["boots"]
    stats = ("feet", {"physical_power":5,"armor":20,"relic_power":15})
    item_model = texture_path_to_item_model("genesis:item/armorsets/shaded_boots", True)
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# VoidbreachHelmet
@add_custom_recipe([
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
    [VoidedFragment, ShadedHelmet, VoidedFragment],
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
])
@add_loot_table
@bolt_item
class VoidbreachHelmet(GenesisItem):
    item_name = ("Voidbreach Helmet", {"color":"light_purple"})
    rarity = "epic"
    category = ["helmet", "void"]
    stats = ("head", {"physical_power":5,"armor":30,"relic_power":20})
    item_model = texture_path_to_item_model("genesis:item/armorsets/voidbreach_helmet", True)
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# VoidbreachChestplate
@add_custom_recipe([
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
    [VoidedFragment, ShadedChestplate, VoidedFragment],
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
])
@add_loot_table
@bolt_item
class VoidbreachChestplate(GenesisItem):
    item_name = ("Voidbreach Chestplate", {"color":"light_purple"})
    rarity = "epic"
    category = ["chestplate", "void"]
    stats = ("chest", {"physical_power":5,"armor":75,"relic_power":20})
    item_model = texture_path_to_item_model("genesis:item/armorsets/voidbreach_chestplate", True)
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# VoidbreachLeggings
@add_custom_recipe([
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
    [VoidedFragment, ShadedLeggings, VoidedFragment],
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
])
@add_loot_table
@bolt_item
class VoidbreachLeggings(GenesisItem):
    item_name = ("Voidbreach Leggings", {"color":"light_purple"})
    rarity = "epic"
    category = ["leggings", "void"]
    stats = ("leg", {"physical_power":5,"armor":55,"relic_power":20})
    item_model = texture_path_to_item_model("genesis:item/armorsets/voidbreach_leggings", True)
    equippable = {"slot":"leg","asset_id":"minecraft:diamond"}

# VoidbreachBoots
@add_custom_recipe([
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
    [VoidedFragment, ShadedBoots, VoidedFragment],
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
])
@add_loot_table
@bolt_item
class VoidbreachBoots(GenesisItem):
    item_name = ("Voidbreach Boots", {"color":"light_purple"})
    rarity = "epic"
    category = ["boots", "void"]
    stats = ("feet", {"physical_power":5,"armor":30,"relic_power":20})
    item_model = texture_path_to_item_model("genesis:item/armorsets/voidbreach_boots", True)
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}


# DreadnaughtHelmet
@add_custom_recipe([
    [MetalAlloy, PyroclasticCore, MetalAlloy],
    [MetalAlloy, "air", MetalAlloy],
    ["air", "netherite_scrap", "air"],
])
@add_loot_table
@bolt_item
class DreadnaughtHelmet(GenesisItem):
    item_name = ("Dreadnaught Helmet", {"color":"dark_red"})
    rarity = "legendary"
    category = ["helmet"]
    stats = ("head", {"attack_speed":-4,"armor":40,"armor_toughness":40,"speed":-5,"relic_power":15})
    item_model = texture_path_to_item_model("genesis:item/armorsets/dreadnaught_helmet", True)
    equippable = {"slot":"head","asset_id":"minecraft:diamond"}

# DreadnaughtChestplate
@add_custom_recipe([
    ["netherite_scrap", "air", "netherite_scrap"],
    [MetalAlloy, PyroclasticCore, MetalAlloy],
    [MetalAlloy, MetalAlloy, MetalAlloy],
])
@add_loot_table
@bolt_item
class DreadnaughtChestplate(GenesisItem):
    item_name = ("Dreadnaught Chestplate", {"color":"dark_red"})
    rarity = "legendary"
    category = ["chestplate"]
    stats = ("chest", {"attack_speed":-5,"armor":90,"armor_toughness":40,"speed":-6,"relic_power":15})
    item_model = texture_path_to_item_model("genesis:item/armorsets/dreadnaught_chestplate", True)
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"}

# DreadnaughtLeggings
@add_custom_recipe([
    [MetalAlloy, PyroclasticCore, MetalAlloy],
    [MetalAlloy, "air", MetalAlloy],
    ["netherite_scrap", "air", "netherite_scrap"],
])
@add_loot_table
@bolt_item
class DreadnaughtLeggings(GenesisItem):
    item_name = ("Dreadnaught Leggings", {"color":"dark_red"})
    rarity = "legendary"
    category = ["leggings"]
    stats = ("leg", {"attack_speed":-5,"armor":70,"armor_toughness":40,"speed":-6,"relic_power":15})
    item_model = texture_path_to_item_model("genesis:item/armorsets/dreadnaught_leggings", True)
    equippable = {"slot":"leg","asset_id":"minecraft:diamond"}

# DreadnaughtBoots
@add_custom_recipe([
    ["air", "netherite_scrap", "air"],
    [MetalAlloy, "air", MetalAlloy],
    [MetalAlloy, PyroclasticCore, MetalAlloy],
])
@add_loot_table
@bolt_item
class DreadnaughtBoots(GenesisItem):
    item_name = ("Dreadnaught Boots", {"color":"dark_red"})
    rarity = "legendary"
    category = ["boots"]
    stats = ("feet", {"attack_speed":-4,"armor":40,"armor_toughness":40,"speed":-5,"relic_power":15})
    item_model = texture_path_to_item_model("genesis:item/armorsets/dreadnaught_boots", True)
    equippable = {"slot":"feet","asset_id":"minecraft:diamond"}