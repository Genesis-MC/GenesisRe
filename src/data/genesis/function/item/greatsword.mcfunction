from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

# IronGreatsword
@add_custom_recipe([
    ["air", "iron_ingot", "air"],
    ["iron_ingot", "iron_ingot", "iron_ingot"],
    ["air", "stick", "air"],
])
@add_loot_table
@bolt_item
class IronGreatsword(GenesisItem):
    item_name = ("Iron Greatsword", {"color":"white"})
    rarity = "common"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":110,"attack_speed":38})
    item_model = texture_path_to_item_model("genesis:item/greatsword/iron_greatsword", True)

# OvergrownGreatsword
@add_custom_recipe([
    ["air", VerdantTwig, "air"],
    [VerdantTwig, "iron_block", VerdantTwig],
    ["air", SteelHilt, "air"],
])
@add_loot_table
@bolt_item
class OvergrownGreatsword(GenesisItem):
    item_name = ("OvergrownGreatsword", {"color":"green"})
    rarity = "uncommon"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":125,"attack_speed":40,"health":40})
    item_model = texture_path_to_item_model("genesis:item/greatsword/overgrown_greatsword", True)

# Zweihander
@add_custom_recipe([
    ["air", MetalAlloy, "air"],
    [MetalAlloy, MetalAlloy, MetalAlloy],
    ["air", SteelHilt, "air"],
])
@add_loot_table
@bolt_item
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
    ["air", BejeweledHilt, "air"],
])
@add_loot_table
@bolt_item
class EverfrostTitanblade(GenesisItem):
    item_name = ("Everfrost Titanblade", {"color":"aqua"})
    rarity = "legendary"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":150,"attack_speed":30,"mana_pool":20,"mana_regen":5,"speed":-50})
    item_model = texture_path_to_item_model("genesis:item/greatsword/everfrost_titanblade", True)
    @right_click_ability(
        name = "polar_vortex",
        description = ,
        mana = ,
        cooldown = ,
    )
    def polar_vortex():

# SwashbucklersGlory
@add_loot_table
@bolt_item
class SwashbucklersGlory(GenesisItem):
    item_name = ("Swashbucklers Glory", {"color":"blue"})
    rarity = "epic"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":140,"attack_speed":35,"armor_toughness":30})
    item_model = texture_path_to_item_model("genesis:item/greatsword/swashbucklers_glory", True)
    @right_click_ability(
        name = "cleave2",
        description = ,
        mana = ,
        cooldown = ,
    )
    def cleave2():
    
# RoyalCleaver
@add_loot_table
@bolt_item
class RoyalCleaver(GenesisItem):
    item_name = ("Royal Cleaver", {"color":"gold"})
    rarity = "epic"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":150,"attack_speed":40,"armor":30,"knockback_resistance":30,"mana_regen":-10,"speed":-25})
    item_model = texture_path_to_item_model("genesis:item/greatsword/royal_cleaver", True)

# Exetol
@add_loot_table
@bolt_item
class Exetol(GenesisItem):
    item_name = ("Exetol", {"color":"red"})
    rarity = "legendary"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":150,"attack_speed":40})
    item_model = texture_path_to_item_model("genesis:item/greatsword/exetol", True)