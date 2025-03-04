from ps_beet_bolt.bolt_item import bolt_item
from genesis:utils import add_loot_table, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:mapping import item_display_uuid
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

# ObsidianBlade
@add_custom_recipe([
    ["air", "air", "obsidian"],
    ["air", "obsidian", "air"],
    [SteelHilt, "air", "air"],
])
@add_loot_table
@bolt_item
class ObsidianBlade(GenesisItem):
    item_name = ("Obsidian Blade", {"color":"white"})
    rarity = "uncommon"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":80,"attack_speed":85,"armor":-10})
    item_model = texture_path_to_item_model("genesis:item/sword/obsidian_blade", True)

# FadingDusk
@add_custom_recipe([
    [ShadeFlux, ShadeFlux, ShadeFlux],
    ["obsidian", ObsidianBlade, "obsidian"],
    [ShadeFlux, ShadeFlux, ShadeFlux],
])
@add_loot_table
@bolt_item
class FadingDusk(GenesisItem):
    item_name = ("Fading Dusk", {"color":"dark_purple"})
    rarity = "rare"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":80,"attack_speed":85,"armor":-10})
    item_model = texture_path_to_item_model("genesis:item/sword/fading_dusk", True)

# SaberCrimson
@add_custom_recipe([
    ["air", "air", CrimsonAlloy],
    ["air", CrimsonAlloy, "air"],
    [BejeweledHilt, "air", "air"],
])
@add_loot_table
@bolt_item
class SaberCrimson(GenesisItem):
    item_name = ("Saber Crimson", {"color":"red"})
    rarity = "epic"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":85,"attack_speed":95,"health":-40})
    item_model = texture_path_to_item_model("genesis:item/sword/saber_crimson", True)

# SaberWarped
@add_custom_recipe([
    ["air", "air", WarpedAlloy],
    ["air", WarpedAlloy, "air"],
    [BejeweledHilt, "air", "air"],
])
@add_loot_table
@bolt_item
class SaberWarped(GenesisItem):
    item_name = ("Saber Warped", {"color":"dark_aqua"})
    rarity = "epic"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":85,"attack_speed":95,"mana_regen":-30})
    item_model = texture_path_to_item_model("genesis:item/sword/saber_warped", True)

# HailstoneBlade
@add_loot_table
@bolt_item
class HailstoneBlade(GenesisItem):
    item_name = ("Hailstone Blade", {"color":"aqua"})
    rarity = "epic"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":75,"attack_speed":100})
    item_model = texture_path_to_item_model("genesis:item/sword/hailstone_blade", True)
    @right_click_ability(
        name = "hailslash",
        description = ,
        mana = ,
        cooldown = ,
    )
    def hailslash():

# Kopesh
@add_loot_table
@bolt_item
class Kopesh(GenesisItem):
    item_name = ("Kopesh", {"color":"dark_red"})
    rarity = "rare"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":80,"attack_speed":85})
    item_model = texture_path_to_item_model("genesis:item/sword/kopesh", True)
    @right_click_ability(
        name = "cleave1",
        description = ,
        mana = ,
        cooldown = ,
    )
    def cleave1():

# AcolyteBlade
@add_loot_table
@bolt_item
class AcolyteBlade(GenesisItem):
    item_name = ("Acolyte Blade", {"color":"dark_red"})
    rarity = "rare"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":85,"attack_speed":80})
    item_model = texture_path_to_item_model("genesis:item/dagger/acolyte_blade", True)
    
# Asophogheny
@add_loot_table
@bolt_item
class Asophogeny(GenesisItem):
    item_name = ("Asophogeny", {"color":"dark_red"})
    rarity = "epic"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":100,"magic_power":90,"attack_speed":80})
    item_model = texture_path_to_item_model("genesis:item/sword/asophogeny", True)
    @right_click_ability(
        name = "blood_root",
        description = ,
        mana = ,
        cooldown = ,
    )
    def blood_root():