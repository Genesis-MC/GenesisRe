from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem


from genesis:item/ingredient import ShadeFlux


@add_custom_recipe([
    [ None  , None       ,"iron_ingot"],
    [ None  ,"iron_ingot", None       ],
    ["stick", None       , None       ],
])
@add_loot_table
@bolt_item
class IronDagger(GenesisItem):
    item_name = ("Iron Dagger", {})
    rarity = "common"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":35,"attack_speed":100})
    item_model = texture_path_to_item_model("genesis:item/dagger/iron_dagger", True)


@add_custom_recipe([
    [ShadeFlux,ShadeFlux ,ShadeFlux],
    [ShadeFlux,IronDagger,ShadeFlux],
    [ShadeFlux,ShadeFlux ,ShadeFlux],
])
@add_loot_table
@bolt_item
class ShadedDagger(GenesisItem):
    item_name = ("Shaded Dagger", {"color":"dark_purple"})
    rarity = "uncommon"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":40,"attack_speed":100,"speed":15})
    item_model = texture_path_to_item_model("genesis:item/dagger/shaded_dagger", True)


@add_custom_recipe([
    ["echo_shard" ,"snowball"   ,"echo_shard" ],
    ["ender_pearl", ShadedDagger,"ender_pearl"],
    ["echo_shard" ,"snowball"   ,"echo_shard" ],
])
@add_loot_table
@bolt_item
class Visharp(GenesisItem):
    item_name = ("Visharp", {"color":"light_purple"})
    rarity = "legendary"
    category = ["void", "dagger"]
    stats = ("mainhand", {"physical_power":60,"attack_speed":110})
    item_model = texture_path_to_item_model("genesis:item/dagger/visharp", True)

    @right_click_ability(
        name = "Voidrend",
        description = "Teleport up to 5 blocks ahead of you and deal 40% Physical Power to opponents in a 3-block radius from your initial position",
        mana = 12, #! not sure how much mana this costs, not visible in the discord screenshot im using as a reference ^^
        cooldown = 4,
    )
    def voidrend():
        tag @s add genesis.caster
        store result storage genesis:temp item.voidrend.damage float 0.04 scoreboard players get @s genesis.stat.physical_power
        execute function ~/../voidrend_macro with storage genesis:temp item.voidrend: #! we could make use of custom damage types
            $execute as @e[distance=..3,tag=!genesis.caster] run damage @s $(damage) minecraft:generic by @a[tag=genesis.caster,limit=1]
        tag @s remove genesis.caster
        tp ^ ^ ^5 #! This is obviously not final lol
