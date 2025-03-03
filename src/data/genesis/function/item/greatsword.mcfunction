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

# OvergrownGreatsword
@add_custom_recipe([
    ["air", VerdantTwig, "air"],
    [VerdantTwig, "iron_block", VerdantTwig],
    ["air", SteelHilt, "air"],
])

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