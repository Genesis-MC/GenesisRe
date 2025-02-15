from ps_beet_bolt.bolt_item import bolt_item
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:utils import add_loot_table
from genesis:item import GenesisItem


@add_custom_recipe([ #! not the correct recipe, ingredients are still missing
    [ None       ,"iron_ingot", None       ],
    ["iron_ingot","iron_ingot","iron_ingot"],
    [ None       ,"stick"     , None       ],
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
