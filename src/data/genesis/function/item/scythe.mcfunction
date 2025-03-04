from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

# IronScythe
@add_custom_recipe([
    ["iron_ingot", "iron_ingot", "air"],
    ["stick", "air", "iron_ingot"],
    ["stick", "air", "air"],
])
@add_loot_table
@bolt_item
class IronScythe(GenesisItem):
    item_name = ("Iron Scythe", {"color":"white"})
    rarity = "common"
    category = ["scythe"]
    stats = ("mainhand", {"physical_power":85,"attack_speed":50})
    item_model = texture_path_to_item_model("genesis:item/scythe/iron_scythe", True)

# VenomlashFang
@add_custom_recipe([
    [VenomSac, "diamond", VenomSac],
    ["diamond", RecluseFang, "diamond"],
    [VenomSac, "diamond", VenomSac],
])
@add_loot_table
@bolt_item
class VenomlashFang(GenesisItem):
    item_name = ("Venomlash Fang", {"color":"dark_purple"})
    rarity = "rare"
    category = ["scythe"]
    stats = ("mainhand", {"physical_power":90,"attack_speed":60})
    item_model = texture_path_to_item_model("genesis:item/scythe/venomlash_fang", True)

# JackOReaper
@add_loot_table
@bolt_item
class JackOReaper(GenesisItem):
    item_name = ("Jack O' Reaper", {"color":"white"})
    rarity = "rare"
    category = ["scythe"]
    stats = ("mainhand", {"physical_power":88,"attack_speed":60})
    item_model = texture_path_to_item_model("genesis:item/scythe/jack_o_reaper", True)

# RecluseFang
@add_loot_table
@bolt_item
class RecluseFang(GenesisItem):
    item_name = ("Recluse Fang", {"color":"red"})
    rarity = "uncommon"
    category = ["scythe"]
    stats = ("mainhand", {"physical_power":85,"attack_speed":50})
    item_model = texture_path_to_item_model("genesis:item/scythe/recluse_fang", True)

# PrismarineScythe
@add_loot_table
@bolt_item
class PrismarineScythe(GenesisItem):
    item_name = ("Prismarine Scythe", {"color":"dark_aqua"})
    rarity = "rare"
    category = ["scythe"]
    stats = ("mainhand", {"physical_power":90,"attack_speed":60,"mana_regen":10})
    item_model = texture_path_to_item_model("genesis:item/scythe/prismarine_scythe", True)

# Riptide
@add_loot_table
@bolt_item
class Riptide(GenesisItem):
    item_name = ("Riptide", {"color":"dark_aqua"})
    rarity = "epic"
    category = ["scythe","elemental"]
    stats = ("mainhand", {"physical_power":95,"attack_speed":65,"mana_regen":15})
    item_model = texture_path_to_item_model("genesis:item/scythe/riptide", True)
    @right_click_ability(
        name = "mana_siphon",
        description = ,
        mana = ,
        cooldown = ,
    )
    def mana_siphon():

# CloudSail
@add_loot_table
@bolt_item
class CloudSail(GenesisItem):
    item_name = ("Cloud Sail", {"color":"white"})
    rarity = "rare"
    category = ["scythe"]
    stats = ("mainhand", {"physical_power":80,"attack_speed":50})
    item_model = texture_path_to_item_model("genesis:item/scythe/cloud_sail", True)
    @right_click_ability(
        name = "cloud_drift",
        description = ,
        mana = ,
        cooldown = ,
    )
    def cloud_drift():

