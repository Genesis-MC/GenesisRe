from ps_beet_bolt.bolt_item import bolt_item
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:utils import add_loot_table
from genesis:item import GenesisItem


@add_custom_recipe([ #! This is not the final recipe but the required items are not implemented yet
    [ None       ,"ender_pearl"         , None ],
    ["echo_shard","chainmail_chestplate","echo_shard"],
    [ None       ,"ender_pearl"         , None ],
])
@add_loot_table
@bolt_item
class EtherealChestplate(GenesisItem):
    item_name = ("Ethereal Chestplate", {"color":"dark_aqua"})
    item_model = "diamond_chestplate" #! use custom texture instead
    equippable = {"slot":"chest","asset_id":"minecraft:diamond"} #! use custom texture instead
    stats = ("chest", {"armor":80,"armor_toughness":10})
    category = ["chestplate"]
    rarity = "epic"
    passives = [{
        "name": "Steadfast",
        "description": "Every 12 seconds, after taking damage, gain +100 Knockback Resistance for 5 seconds.",
    }]

    @on_attacked(full_slot = 'armor.chest')
    def gain_knockback_resistance():
        say NOT IMPLEMENTED YET #! can be added when passive cooldown is a thing
