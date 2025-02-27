from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, break_text_into_lines, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem


@add_loot_table
@bolt_item
class ShadeFlux(GenesisItem):
    category = ["ingredient"]
    item_name = ("Shade Flux", {"color":"dark_purple"})
    rarity = "uncommon"
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "Mesmerizingly beautiful... and beautifully ominous",
        "item.genesis.shade_flux.lore",
        italic = True,
    )
    item_model = texture_path_to_item_model("genesis:item/ingredient/shade_flux")
