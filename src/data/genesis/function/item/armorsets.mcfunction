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

# SteelandureChestplate
@add_custom_recipe([
    ["iron_ingot", "chain", "iron_ingot"],
    ["chain", "iron_chestplate", "chain"],
    ["iron_ingot", "chain", "iron_ingot"],
])

# SteelandureLeggings
@add_custom_recipe([
    ["iron_ingot", "chain", "iron_ingot"],
    ["chain", "iron_leggings", "chain"],
    ["iron_ingot", "chain", "iron_ingot"],
])

# SteelandureBoots
@add_custom_recipe([
    ["iron_ingot", "chain", "iron_ingot"],
    ["chain", "iron_boots", "chain"],
    ["iron_ingot", "chain", "iron_ingot"],
])


# ReinforcedsteelandureHelmet
@add_custom_recipe([
    ["chain", "chain", "chain"],
    [MetalAlloy, SteelAndureHelmet, MetalAlloy],
    ["chain", "chain", "chain"],
])

# ReinforcedsteelandureChestplate
@add_custom_recipe([
    ["chain", "chain", "chain"],
    [MetalAlloy, SteelAndureChestplate, MetalAlloy],
    ["chain", "chain", "chain"],
])

# ReinforcedsteelandureLeggings
@add_custom_recipe([
    ["chain", "chain", "chain"],
    [MetalAlloy, SteelAndureLeggings, MetalAlloy],
    ["chain", "chain", "chain"],
])

# ReinforcedsteelandureBoots
@add_custom_recipe([
    ["chain", "chain", "chain"],
    [MetalAlloy, SteelAndureBoots, MetalAlloy],
    ["chain", "chain", "chain"],
])


# ApprenticeHat
@add_custom_recipe([
    [Cloth, ManaCloth, Cloth],
    [Cloth, "leather_helmet", Cloth],
    [Cloth, ManaCloth, Cloth],
])

# ApprenticeRobe
@add_custom_recipe([
    [Cloth, ManaCloth, Cloth],
    [Cloth, "leather_chestplate", Cloth],
    [Cloth, ManaCloth, Cloth],
])

# ApprenticeTrousers
@add_custom_recipe([
    [Cloth, ManaCloth, Cloth],
    [Cloth, "leather_leggings", Cloth],
    [Cloth, ManaCloth, Cloth],
])

# ApprenticeBoots
@add_custom_recipe([
    [Cloth, ManaCloth, Cloth],
    [Cloth, "leather_boots", Cloth],
    [Cloth, ManaCloth, Cloth],
])


# MageHat
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeHat, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])

# MageRobe
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeRobe, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])

# MageTrousers
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeTrousers, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])

# MageBoots
@add_custom_recipe([
    [ManaCloth, ArcaneCloth, ManaCloth],
    [ManaCloth, ApprenticeBoots, ManaCloth],
    [ManaCloth, ArcaneCloth, ManaCloth],
])


# ArchmageHat
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageHat, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])

# ArchmageRobe
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageRobe, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])

# ArchmageTrousers
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageTrousers, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])

# ArchmageBoots
@add_custom_recipe([
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
    [ArcaneCloth, MageBoots, ArcaneCloth],
    [ArcaneCloth, ArcaneCloth, ArcaneCloth],
])


# VoidbreachHelmet
@add_custom_recipe([
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
    [VoidedFragment, ShadedHelmet, VoidedFragment],
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
])

# VoidbreachChestplate
@add_custom_recipe([
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
    [VoidedFragment, ShadedChestplate, VoidedFragment],
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
])

# VoidbreachLeggings
@add_custom_recipe([
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
    [VoidedFragment, ShadedLeggings, VoidedFragment],
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
])

# VoidbreachBoots
@add_custom_recipe([
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
    [VoidedFragment, ShadedBoots, VoidedFragment],
    ["crying_obsidian", VoidedFragment, "crying_obsidian"],
])


# DreadnaughtHelmet
@add_custom_recipe([
    [MetalAlloy, PyroclasticCore, MetalAlloy],
    [MetalAlloy, "air", MetalAlloy],
    ["air", "netherite_scrap", "air"],
])

# DreadnaughtChestplate
@add_custom_recipe([
    ["netherite_scrap", "air", "netherite_scrap"],
    [MetalAlloy, PyroclasticCore, MetalAlloy],
    [MetalAlloy, MetalAlloy, MetalAlloy],
])

# DreadnaughtLeggings
@add_custom_recipe([
    [MetalAlloy, PyroclasticCore, MetalAlloy],
    [MetalAlloy, "air", MetalAlloy],
    ["netherite_scrap", "air", "netherite_scrap"],
])

# DreadnaughtBoots
@add_custom_recipe([
    ["air", "netherite_scrap", "air"],
    [MetalAlloy, "air", MetalAlloy],
    [MetalAlloy, PyroclasticCore, MetalAlloy],
])